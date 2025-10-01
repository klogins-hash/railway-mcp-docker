# GitHub Repository Setup Instructions

## Manual Setup (Recommended)

1. **Create a new repository on GitHub:**
   - Go to https://github.com/new
   - Repository name: `railway-mcp-docker`
   - Description: `Docker deployment setup for Railway MCP server`
   - Set to Public
   - Don't initialize with README (we already have one)
   - Click "Create repository"

2. **Push your local repository:**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/railway-mcp-docker.git
   git push -u origin main
   ```

## Deploy to Railway

### Option 1: Using the Deploy Script
```bash
./deploy.sh
```

### Option 2: Manual Railway Deployment
```bash
# Initialize Railway project
railway init --name "railway-mcp-server"

# Set environment variables
railway variables set RAILWAY_API_TOKEN="0bc37f0c-3477-4ad6-a430-a50ed86a1680"
railway variables set NODE_ENV="production"

# Deploy
railway up
```

### Option 3: Deploy from GitHub
1. Connect your GitHub repository to Railway
2. Set environment variables in Railway dashboard
3. Railway will automatically deploy on git push

## GitHub Actions Setup (Optional)

To enable automatic deployment on git push:

1. **Get Railway tokens:**
   - Service ID: Get from Railway dashboard
   - Railway Token: Generate from Railway settings

2. **Add GitHub Secrets:**
   - Go to your repo → Settings → Secrets and variables → Actions
   - Add these secrets:
     - `RAILWAY_TOKEN`: Your Railway deployment token
     - `RAILWAY_SERVICE_ID`: Your Railway service ID
     - `RAILWAY_API_TOKEN`: Your Railway API token

3. **Push to main branch** - deployment will trigger automatically

## Repository Structure

```
railway-mcp-docker/
├── Dockerfile              # Container definition
├── docker-compose.yml      # Local development
├── railway.json           # Railway configuration
├── deploy.sh              # Deployment script
├── .env.example           # Environment template
├── .gitignore            # Git ignore rules
├── README.md             # Project documentation
└── .github/
    └── workflows/
        └── deploy.yml     # GitHub Actions workflow
```

## Next Steps

1. Create the GitHub repository
2. Push your code
3. Deploy to Railway using one of the methods above
4. Your Railway MCP server will be accessible via Railway's provided URL
