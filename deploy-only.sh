#!/bin/bash
set -euo pipefail

PROJECT_NAME="ayletna_temp"
REPO_URL="https://github.com/fabughali/${PROJECT_NAME}.git"
SITE_URL="https://fabughali.github.io/${PROJECT_NAME}/"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "📦 Building Flutter web app..."
cd "$ROOT_DIR"
flutter build web --release --base-href "/${PROJECT_NAME}/"

echo "📄 Copying README.md and PRD into build output..."
cp -f "$ROOT_DIR/README.md" "$ROOT_DIR/build/web/README.md"
cp -f "$ROOT_DIR/docs/prdv1.md" "$ROOT_DIR/build/web/prd.md"

cd "$ROOT_DIR/build/web"

echo "🚀 Initializing Git for deployment..."
rm -rf .git
git init
git checkout -b main
git add .
git commit -m "FRESH DEPLOYMENT: Only built web files - $(date)"

git remote add origin "$REPO_URL"

echo "🔥 Force-pushing to gh-pages branch..."
git push -f origin main:gh-pages

echo "✅ Deployment completed!"
echo "🌐 Your app is live at: ${SITE_URL}"
