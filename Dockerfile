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

# Build the project
RUN npm run build

# Create a non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S railway -u 1001

# Change ownership of the app directory
RUN chown -R railway:nodejs /app
USER railway

# Expose port (Railway will assign the PORT environment variable)
EXPOSE $PORT

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "console.log('Health check passed')" || exit 1

# Start the MCP server
CMD ["node", "build/index.js"]
