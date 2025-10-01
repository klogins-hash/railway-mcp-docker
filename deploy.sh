#!/bin/bash

# Railway MCP Docker Deployment Script
echo "🚀 Railway MCP Docker Deployment"
echo "================================="

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Please install it first:"
    echo "   npm install -g @railway/cli"
    exit 1
fi

# Check if user is logged in
if ! railway whoami &> /dev/null; then
    echo "❌ Not logged into Railway. Please run:"
    echo "   railway login"
    exit 1
fi

echo "✅ Railway CLI found and authenticated"

# Create new Railway project
echo "📦 Creating new Railway project..."
railway init --name "railway-mcp-server"

# Set environment variables
echo "🔧 Setting environment variables..."
railway variables set RAILWAY_API_TOKEN="0bc37f0c-3477-4ad6-a430-a50ed86a1680"
railway variables set NODE_ENV="production"

# Deploy to Railway
echo "🚀 Deploying to Railway..."
railway up

echo "✅ Deployment complete!"
echo "🌐 Your Railway MCP server should be available at your Railway project URL"
echo "📊 Check deployment status: railway status"
echo "📝 View logs: railway logs"
