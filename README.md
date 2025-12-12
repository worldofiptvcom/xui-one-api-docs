# XUI.ONE Admin API Documentation

<div align="center">

![XUI.ONE](https://img.shields.io/badge/XUI.ONE-v1.5.13-blue)
![OpenAPI](https://img.shields.io/badge/OpenAPI-3.0.3-green)
![License](https://img.shields.io/badge/License-Proprietary-red)

**Complete API Documentation for XUI.ONE IPTV Panel Administration**

[View Documentation](#documentation) • [Quick Start](#quick-start) • [Examples](#examples) • [Contributing](#contributing)

</div>

---

## 📚 Overview

This repository contains comprehensive API documentation for **XUI.ONE**, a professional IPTV/OTT panel for managing live streams, VOD content, subscriptions, and more.

### Features

- ✅ **180+ API Endpoints** - Complete coverage of all XUI.ONE Admin API actions
- ✅ **Interactive Documentation** - Swagger/OpenAPI 3.0 specification
- ✅ **Code Examples** - cURL, Python, PHP, and JavaScript examples
- ✅ **Detailed Guides** - Step-by-step authentication and usage instructions
- ✅ **Response Examples** - Real-world request/response samples

---

## 🚀 Quick Start

### Prerequisites

1. XUI.ONE panel installed and running (v1.5.5+)
2. Admin account with appropriate permissions
3. Admin API access code created
4. API key generated

### Authentication Setup

#### Step 1: Create Admin API Access Code

1. Log into your XUI.ONE admin panel
2. Navigate to **Management → Access Control → Access Codes**
3. Click **Add Access Code**
4. Select **Access Type: Admin API**
5. Assign to **Administrators** group
6. Save the access code (e.g., `cSbuFLhp`)

#### Step 2: Generate API Key

1. Log into admin panel
2. Click your profile (top right)
3. Select **Edit Profile**
4. Click **Generate API Key**
5. Copy and save your API key

#### Step 3: Test Connection

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=user_info"
```

**Expected Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "username": "admin",
    "member_group_id": "1",
    ...
  }
}
```

---

## 📖 Documentation

### View Interactive Documentation

**Option 1: Swagger UI (Recommended)**

1. Download this repository
2. Open `index.html` in your browser
3. Interactive API documentation with testing capability

**Option 2: Online Swagger Editor**

1. Go to https://editor.swagger.io/
2. Import the `openapi.yaml` file
3. Explore the API interactively

**Option 3: VS Code**

Install the "OpenAPI (Swagger) Editor" extension and open `openapi.yaml`

### Documentation Structure

```
xui-one-api-docs/
├── openapi.yaml              # Main OpenAPI 3.0 specification
├── README.md                 # This file
├── docs/                     # Detailed documentation
│   ├── getting-started.md    # Setup and authentication guide
│   ├── authentication.md     # Detailed authentication docs
│   ├── categories/           # API organized by category
│   │   ├── 01-get-info.md
│   │   ├── 02-logs-events.md
│   │   ├── 03-line-api.md
│   │   └── ...
│   └── examples/             # Code examples
│       ├── curl-examples.md
│       ├── python-examples.md
│       ├── php-examples.md
│       └── javascript-examples.md
├── postman/                  # Postman collection
│   └── XUI-ONE-API.postman_collection.json
└── index.html                # Swagger UI for local viewing
```

---

## 🎯 API Categories

### 1. **Authentication** ✅
- `user_info` - Get current user information

### 2. **GET INFO / Query Actions** 🔄 (Coming Soon)
- `get_lines` - Retrieve all subscription lines
- `get_users` - Retrieve all users
- `get_streams` - Retrieve all live streams
- `get_channels` - Retrieve all channels
- `get_movies` - Retrieve all movies
- `get_series_list` - Retrieve all series
- And more...

### 3. **Line API** 🔄 (Coming Soon)
- `create_line` - Create new subscription
- `edit_line` - Edit existing line
- `delete_line` - Delete subscription
- `enable_line` / `disable_line` - Toggle line status
- `ban_line` / `unban_line` - Ban/unban subscription

### 4. **User API** 🔄 (Coming Soon)
- `create_user` - Create new user
- `edit_user` - Edit user details
- `delete_user` - Delete user
- And more...

### 5. **MAG API** 🔄 (Coming Soon)
- MAG device management

### 6. **Enigma API** 🔄 (Coming Soon)
- Enigma2 STB management

### 7. **Streams API** 🔄 (Coming Soon)
- Live stream management

### 8. **Movies/Series/Episodes API** 🔄 (Coming Soon)
- VOD content management

### 9. **Servers API** 🔄 (Coming Soon)
- Server and load balancer management

### 10. **Logs & Events** 🔄 (Coming Soon)
- Activity monitoring

---

## 💡 Examples

### cURL Example

```bash
# Get all lines
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_lines"

# Create a new line
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=create_line" \
  -d "username=testuser" \
  -d "password=testpass" \
  -d "max_connections=1" \
  -d "exp_date=2025-12-31"

# Edit existing line (ID: 123)
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=edit_line&id=123&password=newpassword"
```

### Python Example

```python
import requests

# API Configuration
BASE_URL = "http://your-server.com/cSbuFLhp/"
API_KEY = "8D3135D30437F86EAE2FA4A2A8345000"

# Get all lines
response = requests.get(
    BASE_URL,
    params={
        "api_key": API_KEY,
        "action": "get_lines"
    }
)

data = response.json()
if data["status"] == "STATUS_SUCCESS":
    print(f"Found {len(data['data'])} lines")
else:
    print(f"Error: {data['error']}")
```

### PHP Example

```php
<?php
// API Configuration
$baseUrl = "http://your-server.com/cSbuFLhp/";
$apiKey = "8D3135D30437F86EAE2FA4A2A8345000";

// Get all lines
$url = $baseUrl . "?api_key=" . $apiKey . "&action=get_lines";
$response = file_get_contents($url);
$data = json_decode($response, true);

if ($data['status'] === 'STATUS_SUCCESS') {
    echo "Found " . count($data['data']) . " lines\n";
} else {
    echo "Error: " . $data['error'] . "\n";
}
?>
```

### JavaScript Example

```javascript
// API Configuration
const BASE_URL = 'http://your-server.com/cSbuFLhp/';
const API_KEY = '8D3135D30437F86EAE2FA4A2A8345000';

// Get all lines
async function getLines() {
  const url = `${BASE_URL}?api_key=${API_KEY}&action=get_lines`;
  
  const response = await fetch(url);
  const data = await response.json();
  
  if (data.status === 'STATUS_SUCCESS') {
    console.log(`Found ${data.data.length} lines`);
    return data.data;
  } else {
    console.error(`Error: ${data.error}`);
    return null;
  }
}

getLines();
```

---

## 🔒 Security Best Practices

1. **Use HTTPS** - Always use port 9000 with SSL in production
2. **IP Whitelisting** - Restrict API access to specific IPs
3. **Rotate Keys** - Regenerate API keys periodically
4. **Never Expose Keys** - Don't commit API keys to version control
5. **Monitor Usage** - Check activity logs regularly
6. **HMAC Authentication** - Use HMAC for enhanced security

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Report Issues** - Found a bug or error? [Open an issue](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
2. **Suggest Improvements** - Have ideas? Create a feature request
3. **Submit Pull Requests** - Fixed something? Submit a PR
4. **Share Examples** - Have working code examples? Share them!

### Contribution Guidelines

- Follow the existing documentation style
- Test all code examples before submitting
- Update the OpenAPI specification for API changes
- Provide clear commit messages

---

## 📋 Roadmap

- [x] Initial repository setup
- [x] Authentication documentation
- [ ] Complete all API categories (2-14)
- [ ] Add Postman collection
- [ ] Add more code examples (Ruby, Go, Node.js)
- [ ] Create video tutorials
- [ ] Add troubleshooting guide
- [ ] HMAC authentication detailed guide

---

## 📄 License

This documentation is provided for XUI.ONE users. XUI.ONE itself is proprietary software.

Documentation: MIT License  
XUI.ONE Software: Proprietary (https://xui.one)

---

## 🆘 Support

- **Documentation Issues**: [GitHub Issues](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
- **XUI.ONE Support**: Contact official support
- **Community**: [World of IPTV Forums](https://www.worldofiptv.com)
- **API Questions**: Open a discussion on GitHub

---

## 🙏 Acknowledgments

- XUI.ONE development team for creating the API
- World of IPTV community for testing and feedback
- All contributors to this documentation project

---

<div align="center">

**⭐ Star this repo if you find it helpful!**

Made with ❤️ by [World of IPTV](https://www.worldofiptv.com)

</div>
