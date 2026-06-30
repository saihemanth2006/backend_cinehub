#!/bin/bash

# ═════════════════════════════════════════════════════════════
# CineHub Backend — Development Startup Script
# ═════════════════════════════════════════════════════════════
# This script handles all setup and startup for the CineHub backend.
# Usage: ./start-dev.sh

set -e  # Exit on error

echo "╔═════════════════════════════════════════════╗"
echo "║  🎬 CineHub Backend — Startup Script        ║"
echo "╚═════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ── Check prerequisites ─────────────────────────────────

echo "📋 Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
  echo -e "${RED}❌ Node.js not found${NC}"
  echo "   Install from: https://nodejs.org/"
  exit 1
fi
echo -e "${GREEN}✓ Node.js $(node --version)${NC}"

# Check npm
if ! command -v npm &> /dev/null; then
  echo -e "${RED}❌ npm not found${NC}"
  exit 1
fi
echo -e "${GREEN}✓ npm $(npm --version)${NC}"

# Check if in server directory
if [ ! -f "package.json" ]; then
  echo -e "${RED}❌ package.json not found${NC}"
  echo "   Please run this script from the 'server' directory"
  exit 1
fi

echo ""

# ── Check .env file ────────────────────────────────────

if [ ! -f ".env" ]; then
  echo -e "${YELLOW}⚠️  .env file not found${NC}"
  
  if [ -f ".env.example" ]; then
    echo "   Creating .env from .env.example..."
    cp .env.example .env
    echo -e "${GREEN}✓ .env created${NC}"
    echo "   ⚠️  Please update .env with your actual configuration"
    echo "   Then run this script again"
    exit 0
  else
    echo -e "${RED}❌ .env.example not found${NC}"
    exit 1
  fi
fi

echo -e "${GREEN}✓ .env file exists${NC}"
echo ""

# ── Install dependencies ───────────────────────────────

echo "📦 Installing dependencies..."
if npm install --silent; then
  echo -e "${GREEN}✓ Dependencies installed${NC}"
else
  echo -e "${RED}❌ Failed to install dependencies${NC}"
  exit 1
fi

echo ""

# ── Check MongoDB ────────────────────────────────────

echo "🗄️  Checking MongoDB..."
if grep -q "mongodb+srv://" .env || grep -q "mongodb://localhost" .env; then
  echo -e "${GREEN}✓ MongoDB URI configured${NC}"
  
  # Try local connection if not using Atlas
  if grep -q "mongodb://localhost" .env; then
    if command -v mongod &> /dev/null; then
      echo "   💡 Tip: Start MongoDB with: brew services start mongodb-community"
    fi
  fi
else
  echo -e "${YELLOW}⚠️  MongoDB not configured${NC}"
  echo "   Please set MONGODB_URI in .env"
fi

echo ""

# ── Check AI Keys ────────────────────────────────────

echo "🤖 Checking AI Configuration..."
if grep -q "GEMINI_API_KEY=" .env && ! grep -q "GEMINI_API_KEY=your" .env; then
  echo -e "${GREEN}✓ Gemini API key configured${NC}"
elif grep -q "OPENAI_API_KEY=" .env && ! grep -q "OPENAI_API_KEY=sk-your" .env; then
  echo -e "${GREEN}✓ OpenAI API key configured${NC}"
else
  echo -e "${YELLOW}⚠️  No AI API keys configured${NC}"
  echo "   Set GEMINI_API_KEY or OPENAI_API_KEY in .env"
  echo "   Get free tier keys from:"
  echo "   • Gemini: https://aistudio.google.com/app/apikey"
  echo "   • OpenAI: https://platform.openai.com/api-keys"
fi

echo ""

# ── Start server ────────────────────────────────────

echo "🚀 Starting development server..."
echo ""

npm run dev
