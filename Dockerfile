FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/jason-tan-swe/railway-mcp.git .

RUN npm install

RUN npm install express cors

RUN npm run build

COPY <<EOF /http-server.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'healthy' });
});

app.get('/', (req, res) => {
  res.json({ message: 'Railway MCP Server' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

EXPOSE 8080

CMD ["node", "http-server.js"]
