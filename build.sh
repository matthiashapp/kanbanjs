#!/bin/bash

# Complete build and deploy script for Kanban Board
set -e

echo "🏗️  Starting build and deployment process..."

# Function to display help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -s, --simple     Use simple minification (no npm required)"
    echo "  -n, --npm        Use npm-based minification (requires npm install)"
    echo "  -o, --original   Deploy original file without minification"
    echo "  -h, --help       Show this help message"
    echo ""
    echo "If no option is specified, it will try npm first, then fall back to simple."
}

# Default behavior
use_npm=true
use_simple=false
use_original=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--simple)
            use_npm=false
            use_simple=true
            shift
            ;;
        -n|--npm)
            use_npm=true
            use_simple=false
            shift
            ;;
        -o|--original)
            use_original=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# If original flag is set, just deploy
if [ "$use_original" = true ]; then
    echo "📦 Deploying original file..."
    ./deploy.sh
    exit 0
fi

# Try npm-based minification first
if [ "$use_npm" = true ]; then
    if command -v npm &> /dev/null; then
        if [ ! -d "node_modules" ]; then
            echo "📦 Installing dependencies..."
            npm install
        fi
        echo "🗜️  Using npm-based minification..."
        npm run minify
        if [ $? -eq 0 ]; then
            echo "✅ npm minification successful!"
            ./deploy.sh
            exit 0
        else
            echo "❌ npm minification failed, falling back to simple minification..."
            use_simple=true
        fi
    else
        echo "⚠️  npm not found, using simple minification..."
        use_simple=true
    fi
fi

# Use simple minification as fallback
if [ "$use_simple" = true ]; then
    echo "🗜️  Using simple minification..."
    ./minify-simple.sh
    ./deploy.sh
fi
