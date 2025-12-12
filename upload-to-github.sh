#!/bin/bash

# XUI.ONE API Documentation - Git Upload Script
# This script will initialize git and push all files to GitHub

echo "================================================"
echo "  XUI.ONE API Documentation - Git Upload"
echo "================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/worldofiptvcom/xui-one-api-docs.git"
BRANCH="main"

# Step 1: Initialize Git (if not already initialized)
echo -e "${BLUE}Step 1: Initializing Git repository...${NC}"
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}✓ Git initialized${NC}"
else
    echo -e "${GREEN}✓ Git already initialized${NC}"
fi
echo ""

# Step 2: Add remote
echo -e "${BLUE}Step 2: Setting up remote repository...${NC}"
if git remote | grep -q "origin"; then
    echo -e "${YELLOW}⚠ Remote 'origin' already exists. Updating URL...${NC}"
    git remote set-url origin $REPO_URL
else
    git remote add origin $REPO_URL
fi
echo -e "${GREEN}✓ Remote configured: $REPO_URL${NC}"
echo ""

# Step 3: Add all files
echo -e "${BLUE}Step 3: Adding files to git...${NC}"
git add .
echo -e "${GREEN}✓ Files staged for commit${NC}"
echo ""

# Step 4: Show what will be committed
echo -e "${BLUE}Files to be committed:${NC}"
git status --short
echo ""

# Step 5: Commit
echo -e "${BLUE}Step 4: Creating commit...${NC}"
read -p "Enter commit message (or press Enter for default): " COMMIT_MSG
if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Initial commit: Add XUI.ONE API documentation with authentication section"
fi
git commit -m "$COMMIT_MSG"
echo -e "${GREEN}✓ Commit created${NC}"
echo ""

# Step 6: Set branch name
echo -e "${BLUE}Step 5: Setting branch name...${NC}"
git branch -M $BRANCH
echo -e "${GREEN}✓ Branch set to: $BRANCH${NC}"
echo ""

# Step 7: Push to GitHub
echo -e "${BLUE}Step 6: Pushing to GitHub...${NC}"
echo -e "${YELLOW}You may be prompted for your GitHub username and password/token${NC}"
git push -u origin $BRANCH

# Check if push was successful
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}================================================${NC}"
    echo -e "${GREEN}  ✓ Successfully uploaded to GitHub!${NC}"
    echo -e "${GREEN}================================================${NC}"
    echo ""
    echo -e "View your repository at:"
    echo -e "${BLUE}https://github.com/worldofiptvcom/xui-one-api-docs${NC}"
    echo ""
    echo -e "Next steps:"
    echo "1. Visit the repository URL above"
    echo "2. Enable GitHub Pages (Settings → Pages → Source: main branch)"
    echo "3. Your documentation will be live at:"
    echo "   https://worldofiptvcom.github.io/xui-one-api-docs/"
    echo ""
else
    echo ""
    echo -e "${YELLOW}================================================${NC}"
    echo -e "${YELLOW}  ⚠ Push failed or requires authentication${NC}"
    echo -e "${YELLOW}================================================${NC}"
    echo ""
    echo "If you're having authentication issues:"
    echo ""
    echo "Option 1: Use Personal Access Token (Recommended)"
    echo "  1. Go to GitHub Settings → Developer settings → Personal access tokens"
    echo "  2. Generate new token (classic) with 'repo' scope"
    echo "  3. Use token as password when prompted"
    echo ""
    echo "Option 2: Use GitHub CLI"
    echo "  1. Install: https://cli.github.com/"
    echo "  2. Run: gh auth login"
    echo "  3. Re-run this script"
    echo ""
    echo "Option 3: Use SSH"
    echo "  1. Add SSH key to GitHub"
    echo "  2. Change remote: git remote set-url origin git@github.com:worldofiptvcom/xui-one-api-docs.git"
    echo "  3. Re-run: git push -u origin main"
    echo ""
fi
