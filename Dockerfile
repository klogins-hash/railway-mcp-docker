# Use Node.js 18 Alpine for smaller image size
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install git (needed for cloning the railway-mcp repo)
RUN apk add --no-cache git

# Clone the railway-mcp repository
RUN git clone https://github.com/jason-tan-swe/railway-mcp.git .

# Install dependencies
RUN npm install

# Install additional dependencies for HTTP server
SUN npm install express cors

# Build the project
RUN npm run build

# Create HTTP wrapper for MCP server
COPY <<EOF /app/http-server.js
const express = require('express');
const cors = require('cors');
const { spawn } = require('child_process');

const app = express();
const PORT = process.env.PORT || 8080;

app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().isoString() });
});

// MCP interaction endpoint
app.post('/mcp', (req, res) => {
  const { method, params } = req.body;
  
  // Spawn MCP server process
  const mcpProcess = spawn('node', ['build/index.js'], {
    stdio: ['pipe', 'pipe', 'pipe'],
    env: { ...process.env }
  });

  let responseData = '';
  let errorData = '';

  mcpProcess.stdout.on('data', (data) => {
    responseData += data.toString();
  });

  mcpProcess.stderr.on('data', (data) => {
    errorData += data.toString();
  });

  mcpProcess.on('close', (code) => {
    if (code === 0) {
      try {
        const result = JSON.parse(responseData);
        res.json(result);
      } catch (e) {
        res.status(500).json({ error: 'Failed to parse MCP response', details: e.message });
      }
    } else {
      res.status(500).json({ error: 'MCP process failed', code, stderr: errorData });
    }
  });

  // Send request to MCP server
  mcpProcess.stdin.write(JSON.stringify({ method, params }) + '\n');
  mcpProcess.stdin.end();
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({ 
    message: 'Railway MCP Server HTTP Wrapper',
    endpoints: {
      'GET /health': 'Health check',
      'POST /mcp': 'MCP communication'
    }
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Railway MCP HTTP server running on port ${PORT}`);
});
EOF

# Create a non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S railway -u 1001

# Change ownership of the app directory
RUN chown -R railway:nodejs /app
USER railway

# Expose port 8080 (Railway will override with PORT env var)
EXPOSE 08080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT:-8080}/health || exit 1

# Start the HTTP server
CMD ["node", "http-server.js"]
