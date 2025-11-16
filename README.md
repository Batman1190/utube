# Utube Clone - GitHub Pages Setup

## 🚀 Quick Start

This repository contains a YouTube clone with enhanced features.

## 📋 GitHub Pages Setup Instructions

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click on **Settings** (top menu)
3. Scroll down to **Pages** in the left sidebar
4. Under **Source**, select:
   - **Branch**: `main` (or `master`)
   - **Folder**: `/ (root)`
5. Click **Save**

### Step 2: Verify File Location

Make sure `index.html` is in the **root directory** of your repository:
```
your-repo/
  ├── index.html
  ├── README.md
  └── ...
```

### Step 3: Access Your Site

After enabling GitHub Pages, your site will be available at:
```
https://YOUR_USERNAME.github.io/REPO_NAME/
```

**Note**: It may take a few minutes for the site to be available after first enabling.

## 🔧 Troubleshooting Blank Page

If you see a blank page, try these solutions:

### 1. Check Browser Console
- Press `F12` to open Developer Tools
- Go to the **Console** tab
- Look for any red error messages
- Share these errors if you need help

### 2. Clear Browser Cache
- Press `Ctrl + Shift + Delete` (Windows) or `Cmd + Shift + Delete` (Mac)
- Clear cached images and files
- Refresh the page

### 3. Check File Size
- The `index.html` file is ~2MB (large file)
- GitHub Pages should handle it, but it may load slowly
- Wait a few seconds for the page to fully load

### 4. Verify GitHub Pages is Active
- Go to repository Settings → Pages
- Make sure it shows "Your site is published at..."
- If it shows an error, check the error message

### 5. Check File Encoding
- Make sure the file is saved as UTF-8
- No special characters in the filename

### 6. Test with a Simple File
- Create a simple `test.html` with just `<h1>Hello World</h1>`
- If that works, the issue is with the main file
- If that doesn't work, GitHub Pages isn't configured correctly

## 🐛 Common Issues

### Issue: "404 - File not found"
**Solution**: Make sure `index.html` is in the root directory, not in a subfolder.

### Issue: "Page is blank"
**Solution**: 
- Check browser console for JavaScript errors
- Verify all external resources are accessible
- Some external APIs may be blocked by CORS

### Issue: "Takes too long to load"
**Solution**: 
- The file is large (2MB), be patient
- Consider optimizing the file size
- Check your internet connection

### Issue: "GitHub Pages not working"
**Solution**:
- Make sure you've enabled GitHub Pages in settings
- Check that you're using the correct branch
- Wait 5-10 minutes after enabling for propagation

## 📝 File Structure

```
.
├── index.html          # Main HTML file (2MB)
├── README.md          # This file
└── .nojekyll          # Prevents Jekyll processing (if needed)
```

## 🔒 Security Note

This file contains YouTube API keys. Make sure:
- Your repository is **private** if you don't want keys exposed
- Or use environment variables for production
- Rotate keys if they're exposed publicly

## 💡 Features

- ✅ Functional hamburger menu
- ✅ YouTube API key rotation system
- ✅ Responsive design
- ✅ All YouTube-like features

## 📞 Need Help?

If you're still experiencing issues:
1. Check the browser console for errors
2. Verify GitHub Pages is enabled
3. Try accessing the raw file: `https://raw.githubusercontent.com/YOUR_USERNAME/REPO_NAME/main/index.html`
4. Check if the file renders locally when opened in a browser

