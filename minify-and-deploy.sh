#!/bin/bash

# Minification and Deployment Script for Kanban Board
set -e

echo "🔧 Starting minification and deployment process..."

# Check if Node.js and npm are installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install Node.js and npm first."
    exit 1
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Create dist directory if it doesn't exist
mkdir -p dist

# Minify the HTML file
echo "🗜️  Minifying index.html..."
npm run minify

# Check if minified file was created
if [ ! -f "dist/index.html" ]; then
    echo "❌ Minification failed - dist/index.html not found"
    exit 1
fi

# Display file size comparison
echo "📊 File size comparison:"
original_size=$(stat -c%s "index.html")
minified_size=$(stat -c%s "dist/index.html")
reduction=$((100 - (minified_size * 100 / original_size)))

echo "   Original:  $(numfmt --to=iec-i --suffix=B $original_size)"
echo "   Minified:  $(numfmt --to=iec-i --suffix=B $minified_size)"
echo "   Reduction: ${reduction}%"

# Deploy the minified version
echo "🚀 Deploying minified version..."
scp dist/index.html nc:/var/www/kanbanjs/index.html

echo "✅ Deployment completed successfully!"
echo "📍 The minified file has been deployed to your server."
