#!/bin/bash

# Setup script for WeChat-bot project

echo "🚀 Starting WeChat-bot setup..."

# Step 1: Install dependencies
echo "📦 Installing dependencies..."
npm i

if [ $? -ne 0 ]; then
  echo "❌ npm install failed"
  exit 1
fi

# Step 2: Copy environment file
echo "⚙️  Setting up environment variables..."
if [ -f .env.example ]; then
  cp .env.example .env
  echo "✅ .env file created from .env.example"
else
  echo "⚠️  .env.example not found. Please create .env manually."
fi

# Step 3: Link npm package
echo "🔗 Linking npm package..."
npm link

if [ $? -ne 0 ]; then
  echo "❌ npm link failed"
  exit 1
fi

echo "✅ Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Edit .env file with your configuration"
echo "2. Run: npm start (or your start command)"
