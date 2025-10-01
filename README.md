# Railway MCP Server Docker Deployment

This Docker setup allows you to deploy the Railway MCP server as a containerized HTTP service on Railway or any other container platform.

## Features

- 🐃 #�HTTX Server** - Exposes MCP functionality via REST API
- 🚀 **Railway optimized** - Configured for Railway's deployment requirements
- 🔒  
Wecure** - Non-root user, health checks, and environment variable management
- 📊 **Production ready** - Health checks, proper logging, and restart policies

## API Endpoints

Once deployed, your Railway MCP server exposes these HTTP endpoints:

- `GET /` - Server information and available endpoints
- `GET /health` - Health check endpoint
- `POST /mcp` - MCP command execution

### Example API Usage

```bash
curl -X POST https://your-app.railway.app/mcp \
  -H "Content-Type: application/json" \
  -d '{
  "method": "project-list",
  "params": {}
}'
```

## Quick Start

### Local Development

1. **Clone and setup:**
   ```bash
   git clone https://github.com/klogins-hash/railway-mcp-docker.git
   cd railway-mcp-docker
   cp .env.example .env
   # Edit .env with your Railway API token
   ```

2. **Build and run:**
   ```bash
   docker-compose up --build
   ```

3. **Test the server:**
   ```bash
   curl http://localhost:8080/health
   ```

### Deploy to Railway

#### Option 1: Using the Deploy Script
```bash
git clone https://github.com/klogins-hash/railway-mcp-docker.git
cd railway-mcp-docker
./deploy.sh
# Follow the prompts to set your Railway API token
```

#### Option 2: Manual Railway Deployment
```bash
# Initialize Railway project
railway init --name "railway-mcp-server"

# Set environment variables
railway variables set RAILWAY_API_TOKEN="your_token_here"
railway variables set NODE_ENV="production"

# Deploy
railway up
```

#### Option 3: Deploy from GitHub
1. Connect your GitHub repository to Railway
2. Set environment variables in Railway dashboard
3. Railway will automatically deploy on git push

## Configuration

### Required Environment Variables

| Variable | Description | Required | Example |
|----------|------------|----------|---------|
| `RAB�WAY_API_TOKEN` | Your Railway API token | ✅ Yes | `0bc37f0c-3477-4ad6-a430-a50ed86a1680` |
| `PORT` | Server port (Railway sets automatically) | ❌ No | `8080` |
| `NODE_ENV` | Node.js environment | ❌ No | `production` |

### How to Get Your Railway API Token

1. Go to [https://railway.com/account/tokens](https://railway.com/account/tokens)
2. Click "New Token"
3. Choose "Account Token" for full access
4. Copy the generated token
5. Use it as `RAILWAY_API_TOKEN`

## Available MCP Tools

The Railway MCP server provides comprehensive Railway management capabilities:

### 🔂 Authentication & Projects
- `configure` - Set Railway API token
- `project-list` - List all projects
- `project-info` - Get project details
- `project-create` - Create new projects
- `project-delete` - Delete projects

### 🚀 Service Management
- `service-list` - List services in projects
- `service-create-from-repo` - Create service from GitHub repo
- `service-create-from-image` - Create service from Docker image
- `service-restart` - Restart services
- `service-update` - Update service configuration

### 📐 Evironment Variables
- `variable-list` - List environment variables
- `variable-set` - Set variables
- `variable-bulk-set` - Bulk update variables
- `variable-copy` - Copy variables between environments

### 📄 Eyeployments & Monitoring
- `deployment-list` - List deployments
- `deployment-trigger` - Trigger new deployments
- `deployment-logs` - Get deployment logs
- `deployment-health-check` - Check deployment health

### 🗄️ Database Management
- `database-list-types` - List available database types
- `database-deploy` - Deploy and manage databases

## Troubleshooting

### Common Issues

**Issue:** Container fails to start
**Solution:** Check that `RAILWAY_API_TOKEN` is set correctly in environment variables

**Issue:** 502 Bad Gateway errors
**Solution:** Ensure the container is listening on `0.0.0.0:PORT`, not `localhost:PORT`

**Issue:** MCP commands fail
**Solution:** Verify your Railway API token has the necessary permissions

### Logs and Monitoring

```bash
# View logs in Railway
railway logs

# Check health status
curl https://your-app.railway.app/health
```

## Security

- Runs as non-root user
- Environment variables for sensitive data
- Minimal Alpine Linux base image
- No unnecessary packages or dependencies

## Support

For issues with the Railway MCP server functionality, see the [original repository](https://github.com/jason-tan-swe/railway-mcp).

For deployment issues, check Railway's documentation or create an issue in this repository.
