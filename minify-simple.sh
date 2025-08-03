#!/bin/bash

# Simple minification script without npm dependencies
# Uses basic tools available on most Linux systems

set -e

echo "🔧 Starting simple HTML minification..."

# Create dist directory if it doesn't exist
mkdir -p dist

# Simple minification using sed commands
# This removes comments, unnecessary whitespace, and empty lines
sed -e 's/<!--.*-->//g' \
    -e 's/^[[:space:]]*//' \
    -e 's/[[:space:]]*$//' \
    -e '/^$/d' \
    -e 's/[[:space:]]\+/ /g' \
    index.html > dist/index.html.tmp

# Further compress by removing spaces around certain characters
sed -e 's/ *> */>/g' \
    -e 's/ *< */</g' \
    -e 's/ *= */=/g' \
    -e 's/; */;/g' \
    -e 's/ *{ */{/g' \
    -e 's/ *} */}/g' \
    -e 's/ *: */:/g' \
    dist/index.html.tmp > dist/index.html

# Clean up temporary file
rm dist/index.html.tmp

# Display file size comparison
echo "📊 File size comparison:"
original_size=$(stat -c%s "index.html")
minified_size=$(stat -c%s "dist/index.html")
reduction=$((100 - (minified_size * 100 / original_size)))

echo "   Original:  $(numfmt --to=iec-i --suffix=B $original_size)"
echo "   Minified:  $(numfmt --to=iec-i --suffix=B $minified_size)"
echo "   Reduction: ${reduction}%"

echo "✅ Simple minification completed!"
echo "📁 Minified file saved as dist/index.html"
