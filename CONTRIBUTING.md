# Contributing to XUI.ONE API Documentation

Thank you for your interest in contributing! This documentation is community-driven and we welcome all contributions.

## 🎯 Ways to Contribute

- 🐛 **Report bugs** - Found incorrect information? Let us know!
- 📝 **Improve documentation** - Fix typos, clarify explanations
- 💡 **Add examples** - Share working code in different languages
- ✨ **Add new endpoints** - Document undocumented API actions
- 🔍 **Test and verify** - Test endpoints and confirm behavior
- 🌍 **Translations** - Help translate documentation

## 📋 Before You Start

1. **Check existing issues** - Someone might already be working on it
2. **Open an issue first** - For major changes, discuss before implementing
3. **Follow the style guide** - Keep documentation consistent
4. **Test your changes** - Verify all code examples work

## 🚀 Quick Start

### Fork and Clone

```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR_USERNAME/xui-one-api-docs.git
cd xui-one-api-docs

# Add upstream remote
git remote add upstream https://github.com/worldofiptvcom/xui-one-api-docs.git
```

### Create a Branch

```bash
# Create a new branch for your contribution
git checkout -b feature/add-streams-api-docs

# Or for bug fixes:
git checkout -b fix/correct-line-api-example
```

### Make Your Changes

Edit the relevant files following our [Style Guide](#style-guide).

### Test Your Changes

```bash
# For OpenAPI changes, validate the spec:
# 1. Open index.html in browser
# 2. Check for validation errors in Swagger UI

# For code examples, test them:
curl "http://your-server.com/cSbuFLhp/?api_key=YOUR_KEY&action=user_info"
```

### Commit Your Changes

```bash
git add .
git commit -m "Add Streams API documentation with examples"

# Use clear commit messages:
# ✅ "Add Python examples for Line API"
# ✅ "Fix typo in authentication guide"
# ✅ "Update get_lines endpoint parameters"
# ❌ "Update docs"
# ❌ "Fix stuff"
```

### Push and Create Pull Request

```bash
git push origin feature/add-streams-api-docs
```

Then open a Pull Request on GitHub with:
- Clear title describing the change
- Description of what was changed and why
- Screenshots if applicable
- Reference to any related issues

## 📝 Style Guide

### OpenAPI Specification

Follow OpenAPI 3.0.3 standards:

```yaml
paths:
  /?action=example:
    get:
      summary: Brief one-line description
      description: |
        Detailed description with examples.
        
        **Example Request:**
        ```bash
        curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=example"
        ```
      operationId: uniqueOperationId
      tags:
        - CategoryName
      parameters:
        - $ref: '#/components/parameters/ApiKey'
        - name: action
          in: query
          required: true
          schema:
            type: string
            enum: [example]
```

### Markdown Documentation

- Use clear headers (h1 for title, h2 for sections, h3 for subsections)
- Include code examples for each operation
- Add response examples (both success and error)
- Use tables for parameter documentation
- Include emojis for visual appeal (but don't overuse)

### Code Examples

Always provide examples in multiple languages when possible:

#### cURL
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=example"
```

#### Python
```python
import requests

response = requests.get(
    "http://your-server.com/cSbuFLhp/",
    params={
        "api_key": "8D3135D30437F86EAE2FA4A2A8345000",
        "action": "example"
    }
)
```

#### PHP
```php
<?php
$url = "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=example";
$response = file_get_contents($url);
$data = json_decode($response, true);
?>
```

#### JavaScript
```javascript
const response = await fetch(
  'http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=example'
);
const data = await response.json();
```

### Placeholder Values

Always use consistent placeholder values:

- **Server**: `your-server.com`
- **Access Code**: `cSbuFLhp`
- **API Key**: `8D3135D30437F86EAE2FA4A2A8345000`
- **IDs**: Use sequential numbers (123, 456, etc.)
- **Usernames**: `testuser`, `user123`, etc.
- **Passwords**: `testpass123`, `securepass`, etc.

### Security Considerations

- **Never** include real API keys, passwords, or server IPs
- Always mention security best practices
- Warn about sensitive operations
- Recommend HTTPS for production

## 🏗️ Project Structure

```
xui-one-api-docs/
├── openapi.yaml              # Main OpenAPI specification
├── README.md                 # Project overview
├── LICENSE                   # License information
├── CONTRIBUTING.md           # This file
├── .gitignore               # Git ignore rules
├── index.html               # Swagger UI viewer
├── docs/                    # Detailed documentation
│   ├── getting-started.md   # Setup guide
│   ├── authentication.md    # Auth details
│   ├── categories/          # API by category
│   │   ├── 01-get-info.md
│   │   ├── 02-logs-events.md
│   │   ├── 03-line-api.md
│   │   └── ...
│   └── examples/            # Code examples
│       ├── curl-examples.md
│       ├── python-examples.md
│       ├── php-examples.md
│       └── javascript-examples.md
└── postman/                 # Postman collection
    └── XUI-ONE-API.postman_collection.json
```

## 📚 Documentation Categories

When adding new API endpoints, place them in the appropriate category:

1. **GET INFO** - Query operations (get_lines, get_users, etc.)
2. **Logs & Events** - Monitoring (activity_logs, live_connections)
3. **Line API** - Subscription management
4. **User API** - User management
5. **MAG API** - MAG device operations
6. **Enigma API** - Enigma2 STB operations
7. **Streams API** - Live stream management
8. **Channel API** - Channel operations
9. **Station API** - Radio station management
10. **Movie API** - VOD movie management
11. **Series API** - Series management
12. **Episode API** - Episode management
13. **Servers API** - Server and load balancer management
14. **Settings & System** - System configuration

## ✅ Pull Request Checklist

Before submitting your PR, ensure:

- [ ] Code examples are tested and working
- [ ] OpenAPI spec validates without errors
- [ ] Markdown is properly formatted
- [ ] No real credentials are included
- [ ] Commit messages are clear
- [ ] Branch is up to date with main
- [ ] Documentation follows style guide
- [ ] Changes are described in PR description

## 🧪 Testing

### Test OpenAPI Specification

1. Open `index.html` in a browser
2. Check for validation errors in Swagger UI
3. Verify examples render correctly
4. Test "Try it out" functionality with your credentials

### Test Code Examples

Test all code examples with a real XUI.ONE instance:

```bash
# Test cURL examples
bash docs/examples/test-curl.sh

# Test Python examples
python docs/examples/test-python.py
```

## 🐛 Reporting Issues

When reporting bugs or issues:

1. **Check existing issues first**
2. **Use the issue template**
3. **Provide details:**
   - What you expected
   - What actually happened
   - Steps to reproduce
   - XUI.ONE version
   - API endpoint affected
4. **Include examples** (sanitize credentials!)

### Issue Template

```markdown
## Description
Brief description of the issue

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Environment
- XUI.ONE Version: 1.5.13
- Endpoint: /?action=get_lines
- Request Method: GET

## Additional Context
Any other relevant information
```

## 💬 Communication

- **GitHub Issues** - Bug reports and feature requests
- **GitHub Discussions** - Questions and general discussion
- **Pull Requests** - Code and documentation contributions

## 🏆 Recognition

Contributors will be:
- Listed in the project README
- Credited in release notes
- Appreciated by the community! 🙏

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License (for documentation). See [LICENSE](LICENSE) file for details.

## ❓ Questions?

- Check the [README](README.md)
- Read the [Getting Started Guide](docs/getting-started.md)
- Open a [GitHub Discussion](https://github.com/worldofiptvcom/xui-one-api-docs/discussions)
- Ask in the [World of IPTV Forums](https://www.worldofiptv.com)

---

## 🙏 Thank You!

Thank you for contributing to make XUI.ONE API documentation better for everyone!

**Happy documenting! 📚✨**
