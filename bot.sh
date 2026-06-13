#!/bin/bash

# WeChat-bot Complete Setup & Start Script
# Integrated script for initialization, configuration, and launching

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_step() {
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}✓ $1${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_info() {
  echo -e "${YELLOW}ℹ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ $1${NC}"
}

# Main execution
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║           WeChat-bot Setup & Startup Script               ║"
echo "║              绫波丽 Bot Management Tool                    ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# ==================== STEP 1: Setup Phase ====================
print_step "Phase 1: Environment Setup"

print_info "Checking Node.js installation..."
if ! command -v node &> /dev/null; then
  print_error "Node.js is not installed. Please install Node.js first."
  exit 1
fi
NODE_VERSION=$(node -v)
print_info "Node.js version: $NODE_VERSION"

print_info "Checking npm installation..."
if ! command -v npm &> /dev/null; then
  print_error "npm is not installed. Please install npm first."
  exit 1
fi
NPM_VERSION=$(npm -v)
print_info "npm version: $NPM_VERSION"

# ==================== STEP 2: Install Dependencies ====================
print_step "Phase 2: Installing Dependencies"

if [ -f "package.json" ]; then
  print_info "Installing npm dependencies..."
  npm i
  if [ $? -ne 0 ]; then
    print_error "npm install failed"
    exit 1
  fi
  print_info "Dependencies installed successfully"
else
  print_error "package.json not found. Please ensure you're in the project root directory."
  exit 1
fi

# ==================== STEP 3: Setup Environment File ====================
print_step "Phase 3: Configuring Environment Variables"

if [ ! -f ".env" ]; then
  if [ -f ".env.example" ]; then
    print_info "Creating .env file from .env.example..."
    cp .env.example .env
    print_info ".env file created successfully"
    print_info "Configuration:"
    cat .env | sed 's/^/  /'
  else
    print_error ".env.example not found. Creating default .env..."
    cat > .env << 'EOF'
BOT_NAME='绫波丽'
ALIAS_WHITELIST='落晖染'

PI_BIN='pi'
PI_AGENT_ARGS='--print --no-session'
WECHAT_STORE_MESSAGES='true'
EOF
    print_info "Default .env file created"
  fi
else
  print_info ".env file already exists. Skipping creation."
  print_info "Current configuration:"
  cat .env | sed 's/^/  /'
fi

# ==================== STEP 4: Link NPM Package ====================
print_step "Phase 4: Linking NPM Package"

print_info "Running npm link..."
npm link
if [ $? -ne 0 ]; then
  print_error "npm link failed"
  exit 1
fi
print_info "npm link completed successfully"

# ==================== STEP 5: Verify Setup ====================
print_step "Phase 5: Verifying Setup"

print_info "Checking node_modules..."
if [ -d "node_modules" ]; then
  print_info "node_modules directory found"
else
  print_error "node_modules directory not found"
  exit 1
fi

print_info "Checking .env configuration..."
if [ -f ".env" ]; then
  print_info ".env file found"
else
  print_error ".env file not found"
  exit 1
fi

# ==================== STEP 6: Start Bot ====================
print_step "Phase 6: Starting WeChat Bot"

print_info "Launching bot with WeChat agent (PI)..."
print_info "Bot Name: 绫波丽"
print_info "Agent: PI"
print_info "Interface: WeChat"
echo ""

# Execute the bot command
wb agent --im wechat --agent pi

# If the command fails
if [ $? -ne 0 ]; then
  print_error "Bot startup failed"
  print_info "Troubleshooting tips:"
  echo "  1. Check if 'wb' command is available (npm link may have failed)"
  echo "  2. Verify .env configuration"
  echo "  3. Ensure all dependencies are installed"
  exit 1
fi
