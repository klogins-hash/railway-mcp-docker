# Railway MCP Server Docker Deployment

This Docker setup allows you to deploy the Railway MCP server as a containerized service on Railway or any other container platform.

## Features

- 🐳 **Docker containerized** - Easy deployment and scaling
- 🚀 **Railway optimized** - Configured for Railway's deployment requirements
- 🔒 **Secure** - Non-root user, health checks, and environment variable management
- 📊 **Production ready** - Health checks, proper logging, and restart policies

## Quick Start

### Local Development

1. **Clone and setup:**
   ```bash
   cd railway-mcp-docker
   cp .env.example .env
   # Edit .env with your Railway API token
   ```

2. **Build and run:**
   ```bash
   docker-compose up --build
   ```

3. **Test the server:**
   The MCP server will be running on `http://localhost:8080`

### Deploy to Railway

1. **Create a new Railway service:**
   ```bash
   railway login
   railway init
   railway add
   ```

2. **Set environment variables:**
   ```bash
   railway variables set RAILWAY_API_TOKEN=your_token_here
   ```

3. **Deploy:**
   ```bash
   railway up
   ```

## Configuration

### Environment Variables

- `RAILWAY_API_TOKEN` - Your Railway API token (required)
- `PORT` - Port for the server (Railway sets this automatically)
- `NODE_ENV` - Environment (production/development)

### Railway Integration

This MCP server provides comprehensive Railway management through these tools:

- **Project Management**: List, create, delete projects
- **Service Management**: Deploy, restart, update services
- **Environment Variables**: Set, list, bulk update variables
- **Deployments**: Trigger, monitor, get logs
- **Database Management**: Deploy and manage databases

## Usage

Once deployed, you can use this MCP server with AI assistants like:

- **Windsurf/Cascade** - Add to `.windsurf/mcp.json`
- **Claude Desktop** - Add to MCP configuration
- **Cursor** - Add to `.cursor/mcp.json`

### Example MCP Configuration

```json
{
  "mcpServers": {
    "Railway": {
      "command": "npx",
      "args": ["-y", "railway-mcp-client"],
      "env": {
        "RAILWAY_MCP_SERVER_URL": "https://your-railway-app.railway.app"
      }
    }
  }
}
```

## Health Monitoring

The container includes health checks that verify the MCP server is responding correctly. Railway will automatically restart unhealthy containers.

## Security

- Runs as non-root user
- Environment variables for sensitive data
- Minimal Alpine Linux base image
- No unnecessary packages or dependencies

## Support

For issues with the Railway MCP server functionality, see the [original repository](https://github.com/jason-tan-swe/railway-mcp).

For deployment issues, check Railway's documentation or create an issue in this repository.
