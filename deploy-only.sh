#!/bin/bash

echo "📦 Building Flutter web app..."
flutter build web --release --base-href /ayletna_temp/

# Enter build output directory
cd build/web

echo "🚀 Initializing Git for deployment..."
git init
git checkout -B main
git add .
git commit -m "FRESH DEPLOYMENT: Only built web files - $(date)"

# Link to your repo
git remote add origin https://github.com/fabughali/ayletna_temp.git

echo "🔥 Force-pushing to gh-pages branch..."
git push -f origin main:gh-pages

echo "✅ Deployment completed!"
echo "🌐 Your app is live at: https://fabughali.github.io/ayletna_temp/"
