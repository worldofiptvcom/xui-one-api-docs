# Deployment Guide

This guide explains how to upload the documentation to GitHub and deploy it online.

## Table of Contents

1. [Automatic Upload (Recommended)](#automatic-upload)
2. [Manual Upload](#manual-upload)
3. [Deploy to GitHub Pages](#deploy-to-github-pages)
4. [Alternative Hosting](#alternative-hosting)

---

## Automatic Upload (Recommended)

### Prerequisites

- Git installed on your system
- GitHub account credentials or Personal Access Token

### Steps

1. **Navigate to the project directory:**

```bash
cd /path/to/xui-one-api-docs
```

2. **Run the upload script:**

```bash
./upload-to-github.sh
```

3. **Follow the prompts:**
   - Enter commit message (or press Enter for default)
   - Provide GitHub credentials when prompted

4. **Done!** Your documentation is now on GitHub.

---

## Manual Upload

If you prefer manual control or the automatic script doesn't work:

### Step 1: Initialize Git

```bash
cd /path/to/xui-one-api-docs
git init
```

### Step 2: Add Remote

```bash
git remote add origin https://github.com/worldofiptvcom/xui-one-api-docs.git
```

### Step 3: Stage Files

```bash
git add .
```

### Step 4: Commit

```bash
git commit -m "Initial commit: Add XUI.ONE API documentation with authentication section"
```

### Step 5: Set Branch

```bash
git branch -M main
```

### Step 6: Push to GitHub

```bash
git push -u origin main
```

**Note:** You'll be prompted for GitHub credentials.

---

## Authentication Options

### Option 1: Personal Access Token (Recommended)

1. **Generate Token:**
   - Go to GitHub: Settings → Developer settings → Personal access tokens → Tokens (classic)
   - Click "Generate new token (classic)"
   - Select scopes: `repo` (Full control of private repositories)
   - Generate and copy the token

2. **Use Token:**
   - When prompted for password, paste your token instead

### Option 2: GitHub CLI

```bash
# Install GitHub CLI
# macOS
brew install gh

# Linux
sudo apt install gh

# Windows
winget install --id GitHub.cli

# Authenticate
gh auth login

# Push repository
git push -u origin main
```

### Option 3: SSH Key

1. **Generate SSH Key:**

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2. **Add to GitHub:**
   - Copy public key: `cat ~/.ssh/id_ed25519.pub`
   - Go to GitHub: Settings → SSH and GPG keys → New SSH key
   - Paste and save

3. **Change Remote URL:**

```bash
git remote set-url origin git@github.com:worldofiptvcom/xui-one-api-docs.git
```

4. **Push:**

```bash
git push -u origin main
```

---

## Deploy to GitHub Pages

After uploading to GitHub, deploy the documentation website:

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Scroll to **Pages** section (left sidebar)
4. Under **Source**:
   - Branch: `main`
   - Folder: `/ (root)`
5. Click **Save**

### Step 2: Wait for Deployment

- GitHub will build your site (takes 1-2 minutes)
- Check the Actions tab to see deployment progress

### Step 3: Access Your Documentation

Your documentation will be available at:

```
https://worldofiptvcom.github.io/xui-one-api-docs/
```

Open `index.html` to view the interactive Swagger UI documentation.

### Custom Domain (Optional)

1. **Add CNAME file:**

```bash
echo "docs.yoursite.com" > CNAME
git add CNAME
git commit -m "Add custom domain"
git push
```

2. **Configure DNS:**
   - Add CNAME record: `docs.yoursite.com` → `worldofiptvcom.github.io`

3. **Update GitHub Pages:**
   - Settings → Pages → Custom domain
   - Enter: `docs.yoursite.com`
   - Save

---

## Alternative Hosting

### Netlify

1. **Connect Repository:**
   - Go to https://netlify.com
   - New site from Git
   - Select your GitHub repository

2. **Build Settings:**
   - Build command: (leave empty)
   - Publish directory: `/`

3. **Deploy:**
   - Click Deploy Site
   - Done! Your site is live

### Vercel

1. **Import Project:**
   - Go to https://vercel.com
   - Import Git Repository
   - Select your repository

2. **Deploy:**
   - Click Deploy
   - Done! Your site is live

### GitLab Pages

1. **Create `.gitlab-ci.yml`:**

```yaml
pages:
  stage: deploy
  script:
    - mkdir .public
    - cp -r * .public
    - mv .public public
  artifacts:
    paths:
      - public
  only:
    - main
```

2. **Push to GitLab:**

```bash
git remote add gitlab https://gitlab.com/yourusername/xui-one-api-docs.git
git push gitlab main
```

### Self-Hosted

1. **Copy Files to Web Server:**

```bash
scp -r xui-one-api-docs/* user@your-server.com:/var/www/html/docs/
```

2. **Configure Nginx:**

```nginx
server {
    listen 80;
    server_name docs.yoursite.com;
    root /var/www/html/docs;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

3. **Restart Nginx:**

```bash
sudo systemctl restart nginx
```

---

## Updating Documentation

When you make changes:

```bash
# Stage changes
git add .

# Commit
git commit -m "Update: Add Streams API documentation"

# Push
git push origin main
```

GitHub Pages will automatically rebuild and deploy.

---

## Troubleshooting

### "Permission Denied" Error

**Solution:**
- Use Personal Access Token instead of password
- Or set up SSH key authentication

### "Repository Not Found" Error

**Solution:**
- Verify repository URL: `git remote -v`
- Ensure repository exists on GitHub
- Check you have access rights

### GitHub Pages Not Working

**Solution:**
- Verify Pages is enabled in repository settings
- Check Actions tab for deployment status
- Ensure `index.html` exists in repository root
- Wait a few minutes for initial deployment

### Changes Not Appearing

**Solution:**
- Clear browser cache
- Wait 1-2 minutes for GitHub Pages rebuild
- Check if git push was successful

---

## Viewing Locally

Before deploying, test locally:

```bash
# Using Python
python3 -m http.server 8000

# Using Node.js
npx http-server

# Using PHP
php -S localhost:8000
```

Then open: `http://localhost:8000/index.html`

---

## Support

- **GitHub Issues:** Report deployment problems
- **GitHub Discussions:** Ask deployment questions
- **World of IPTV:** Community support

---

**Need help?** Open an issue on GitHub with:
- What you tried
- Error messages
- Your operating system
- Screenshots if applicable
