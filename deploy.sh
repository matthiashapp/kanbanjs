#!/bin/bash

# Deploy the minified version if it exists, otherwise deploy original
if [ -f "dist/index.html" ]; then
    echo "🚀 Deploying minified version..."
    scp dist/index.html nc:/var/www/kanbanjs/index.html
else
    echo "⚠️  No minified version found, deploying original..."
    scp index.html nc:/var/www/kanbanjs/index.html
fi