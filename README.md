# Kanban Board

A simple, responsive Kanban board application built with vanilla JavaScript and Tailwind CSS.

## Features

- Drag and drop cards between lanes
- Add/delete lanes and cards
- Persistent storage using localStorage
- Responsive design
- Clean, modern UI

## Deployment & Minification

This project includes several scripts for building and deploying your Kanban board:

### Quick Start

```bash
# Build and deploy (automatic minification)
./build.sh

# Or manually run specific steps
./minify-simple.sh  # Simple minification
./deploy.sh         # Deploy to server
```

### Available Scripts

1. **`build.sh`** - Main build script with multiple options:
   ```bash
   ./build.sh              # Auto-detect best minification method
   ./build.sh --npm        # Use npm-based minification
   ./build.sh --simple     # Use simple shell-based minification
   ./build.sh --original   # Deploy without minification
   ./build.sh --help       # Show help
   ```

2. **`minify-simple.sh`** - Basic minification using shell commands:
   - Removes HTML comments
   - Strips unnecessary whitespace
   - Compresses CSS and JavaScript inline code
   - No dependencies required

3. **`minify-and-deploy.sh`** - Full npm-based minification and deployment:
   - Uses `html-minifier-terser` for advanced minification
   - Requires `npm install` first
   - Provides detailed file size comparison

4. **`deploy.sh`** - Deploys files to your server:
   - Automatically uses minified version if available
   - Falls back to original if no minified version exists

### Setup for npm-based minification

If you want to use the advanced npm-based minification:

```bash
npm install
npm run build
```

### File Size Reduction

The minification process typically reduces file size by 20-40%, improving load times and reducing bandwidth usage.

### Server Configuration

Update the server path in `deploy.sh` and other scripts:
```bash
scp dist/index.html your-server:/path/to/web/directory/
```

## Development

The application stores its state in localStorage, so your board configuration persists between sessions.

### Default Board

If no saved state is found, the application loads with:
- **To Do**: Sample tasks
- **In Progress**: Work in progress items  
- **Done**: Completed items

## Browser Support

Works in all modern browsers that support:
- HTML5 drag and drop API
- localStorage
- ES6 features
