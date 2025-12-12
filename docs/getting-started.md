# Getting Started with XUI.ONE Admin API

Welcome to the XUI.ONE Admin API! This guide will help you get up and running quickly.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Authentication Setup](#authentication-setup)
3. [Making Your First API Call](#making-your-first-api-call)
4. [Understanding Responses](#understanding-responses)
5. [Common Operations](#common-operations)
6. [Troubleshooting](#troubleshooting)
7. [Next Steps](#next-steps)

---

## Prerequisites

Before you begin, ensure you have:

- ✅ **XUI.ONE Panel Installed** - Version 1.5.5 or higher
- ✅ **Admin Access** - Full administrator privileges
- ✅ **Server Access** - Ability to access your XUI.ONE server
- ✅ **API Client** - cURL, Postman, or programming language of choice

### Check Your XUI.ONE Version

SSH into your server and run:

```bash
cat /home/xui/config/config.ini | grep version
```

Or check in the admin panel footer.

---

## Authentication Setup

### Step 1: Create Admin API Access Code

The access code is a unique identifier that protects your API endpoint.

1. **Log into XUI.ONE Admin Panel**
   - Navigate to your panel URL: `http://your-server.com:25500/your-access-code`

2. **Navigate to Access Codes**
   - Click **Management** (left sidebar)
   - Select **Access Control**
   - Click **Access Codes**

3. **Create New Access Code**
   - Click **Add Access Code** button
   - Fill in the form:
     - **Access Type**: Select `Admin API`
     - **Group**: Select `Administrators`
     - **IP Restriction** (Optional but recommended):
       - Add your IP address for security
       - Leave empty to allow all IPs (not recommended for production)

4. **Save and Note Your Access Code**
   - After saving, note your access code (e.g., `cSbuFLhp`)
   - This will be part of your API URL

### Step 2: Generate API Key

The API key authenticates your requests.

1. **Access Your Profile**
   - Click your username (top right corner)
   - Select **Edit Profile**

2. **Generate API Key**
   - Scroll to the API section
   - Click the blue **Generate API Key** button
   - Your API key will be displayed (e.g., `8D3135D30437F86EAE2FA4A2A8345000`)

3. **Save Your API Key Securely**
   - Copy the API key immediately
   - Store it in a password manager or secure location
   - **Never commit this to version control!**

### Step 3: Construct Your Base URL

Your API base URL follows this format:

```
http://your-server.com/<Access-Code>/?api_key=<API-KEY>
```

**Example:**
```
http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000
```

**For HTTPS (Recommended for Production):**
```
https://your-server.com:9000/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000
```

---

## Making Your First API Call

### Test Authentication

Let's verify everything is set up correctly by getting your user information.

#### Using cURL

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=user_info"
```

#### Using Python

```python
import requests

response = requests.get(
    "http://your-server.com/cSbuFLhp/",
    params={
        "api_key": "8D3135D30437F86EAE2FA4A2A8345000",
        "action": "user_info"
    }
)

print(response.json())
```

#### Using PHP

```php
<?php
$url = "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=user_info";
$response = file_get_contents($url);
$data = json_decode($response, true);

print_r($data);
?>
```

#### Using JavaScript (Node.js)

```javascript
const fetch = require('node-fetch');

async function getUserInfo() {
  const url = 'http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=user_info';
  
  const response = await fetch(url);
  const data = await response.json();
  
  console.log(data);
}

getUserInfo();
```

### Expected Success Response

```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "id": "1",
    "username": "admin",
    "member_group_id": "1",
    "email": "admin@example.com",
    "date_registered": "1609459200",
    "last_login": "1734048000",
    "status": "1"
  }
}
```

✅ **Success!** If you see this response, your authentication is working correctly.

---

## Understanding Responses

### Success Response Structure

All successful API calls return:

```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    // Response data here
  }
}
```

- **status**: Always `"STATUS_SUCCESS"` for successful requests
- **data**: Contains the requested information (structure varies by endpoint)

### Error Response Structure

Failed API calls return:

```json
{
  "status": "STATUS_FAILURE",
  "error": "Error message description"
}
```

- **status**: Always `"STATUS_FAILURE"` for failed requests
- **error**: Human-readable error message

### Common Error Messages

| Error Message | Meaning | Solution |
|--------------|---------|----------|
| `Invalid API key` | API key is wrong or expired | Regenerate API key in profile |
| `Access denied` | Access code is incorrect | Verify access code |
| `Missing required parameters` | Required field not provided | Check API documentation |
| `Invalid action` | Action name misspelled | Verify action name |
| `Permission denied` | Insufficient privileges | Check access code group assignment |
| `Resource not found` | ID doesn't exist | Verify the resource ID |

---

## Common Operations

### 1. Get All Subscription Lines

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_lines"
```

### 2. Get Specific Line Details

First, get the line ID from `get_lines`, then:

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_line&id=123"
```

### 3. Create New Subscription Line

```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=create_line" \
  -d "username=testuser" \
  -d "password=testpass123" \
  -d "max_connections=1" \
  -d "exp_date=2025-12-31"
```

### 4. Edit Existing Line

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=edit_line&id=123&password=newpassword&max_connections=2"
```

### 5. Get All Streams

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_streams"
```

### 6. Get Live Connections

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=live_connections"
```

### 7. Get Activity Logs

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=activity_logs"
```

---

## Troubleshooting

### Problem: "Invalid API key" Error

**Solution:**
1. Regenerate your API key in admin profile
2. Ensure you're using the complete key without spaces
3. Check for special characters that need URL encoding

### Problem: "Access denied" Error

**Solution:**
1. Verify your access code is correct
2. Check that the access code is assigned to Administrators group
3. If using IP restriction, verify your current IP is whitelisted

### Problem: Connection Timeout

**Solution:**
1. Check if XUI.ONE service is running: `service xuione status`
2. Verify firewall allows the port (80, 8000, or 9000)
3. Check if nginx is running: `systemctl status nginx`

### Problem: SSL/HTTPS Not Working

**Solution:**
1. Verify SSL certificate is installed in XUI.ONE
2. Use port 9000 for HTTPS: `https://your-server.com:9000/...`
3. Check certificate validity in panel settings

### Problem: Empty Response Data

**Solution:**
1. Check if the resource exists (e.g., lines, streams)
2. Verify you're using the correct action name
3. Check if pagination is needed for large datasets

---

## Best Practices

### Security

1. **Use HTTPS in Production**
   ```
   https://your-server.com:9000/cSbuFLhp/?api_key=...
   ```

2. **IP Whitelist Your API Access**
   - Restrict access code to your application server IPs

3. **Rotate API Keys Regularly**
   - Regenerate keys every 90 days

4. **Never Log API Keys**
   - Sanitize logs to remove sensitive data

5. **Use Environment Variables**
   ```bash
   export XUI_API_KEY="8D3135D30437F86EAE2FA4A2A8345000"
   export XUI_ACCESS_CODE="cSbuFLhp"
   export XUI_SERVER="your-server.com"
   ```

### Performance

1. **Cache Responses**
   - Cache data that doesn't change frequently (streams, movies)

2. **Implement Rate Limiting**
   - Limit to 100 requests per minute

3. **Use Pagination**
   - For large datasets, use limit/offset parameters

4. **Batch Operations**
   - When possible, batch multiple updates

### Error Handling

1. **Always Check Response Status**
   ```python
   if data['status'] != 'STATUS_SUCCESS':
       handle_error(data['error'])
   ```

2. **Implement Retry Logic**
   - Use exponential backoff for transient errors

3. **Log All Errors**
   - Keep detailed logs for debugging

---

## Next Steps

Now that you're set up, explore more API capabilities:

1. 📖 **Read Full API Reference** - Check `openapi.yaml` for all endpoints
2. 🔍 **Explore Categories** - Browse `/docs/categories/` for detailed guides
3. 💻 **Try Code Examples** - See `/docs/examples/` for language-specific examples
4. 📦 **Use Postman** - Import the Postman collection for easy testing
5. 🎯 **Build Your Application** - Start integrating XUI.ONE into your project

### Recommended Reading Order

1. **Line API** - Manage subscriptions
2. **Streams API** - Control live streams
3. **Logs & Events** - Monitor your platform
4. **Movies/Series API** - Manage VOD content
5. **Servers API** - Configure load balancers

---

## Support

Need help?

- 📖 **Documentation**: Check the full API reference
- 🐛 **Issues**: [Report bugs on GitHub](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
- 💬 **Community**: [World of IPTV Forums](https://www.worldofiptv.com)
- 📧 **Official Support**: Contact XUI.ONE team

---

**Happy coding! 🚀**
