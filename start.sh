#!/bin/bash

# Start script for WeChat-bot project

echo "🤖 Starting WeChat-bot..."

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
  echo "📦 Dependencies not found. Installing..."
  npm i
  
  if [ $? -ne 0 ]; then
    echo "❌ npm install failed"
    exit 1
  fi
fi

# Start the bot
echo "🚀 Launching bot with WeChat agent (PI)..."
wb agent --im wechat --agent pi

if [ $? -ne 0 ]; then
  echo "❌ Bot startup failed"
  exit 1
fi
