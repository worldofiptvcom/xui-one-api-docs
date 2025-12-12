# Line API - Subscription Management

Complete documentation for subscription line management in the XUI.ONE Admin API.

## 📋 Overview

The Line API provides complete control over subscription lines (M3U/Xtream Codes accounts). You can create, modify, enable, disable, and delete subscription lines programmatically.

### Available Operations

| Operation | Action | Method | Description |
|-----------|--------|--------|-------------|
| **View** | `get_line` | GET | Get specific line details |
| **Create** | `create_line` | POST | Create new subscription |
| **Update** | `edit_line` | POST | Modify existing line |
| **Delete** | `delete_line` | POST | Permanently remove line |
| **Enable** | `enable_line` | POST | Activate disabled line |
| **Disable** | `disable_line` | POST | Temporarily suspend line |
| **Ban** | `ban_line` | POST | Block abusive account |
| **Unban** | `unban_line` | POST | Remove ban from line |

---

## 🔍 Get Specific Line

### Action: `get_line`

Retrieve detailed information about a specific subscription line.

**Parameters:**
- `id` (required) - Line ID

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_line&id=123"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "id": "123",
    "username": "testuser",
    "password": "testpass123",
    "exp_date": "1735689600",
    "max_connections": "1",
    "is_trial": "0",
    "enabled": "1",
    "is_restreamer": "0",
    "bouquet": "[1,2,3]",
    "notes": "Premium customer",
    "created_at": "1609459200"
  }
}
```

---

## ➕ Create New Line

### Action: `create_line`

Create a new subscription line with specified settings.

**Required Parameters:**
- `username` - Username for the line
- `password` - Password for the line

**Optional Parameters:**
- `max_connections` - Maximum concurrent connections (default: 1)
- `exp_date` - Expiration date (YYYY-MM-DD, timestamp, or relative like "1month")
- `is_trial` - Trial status (0 = No, 1 = Yes)
- `is_restreamer` - Reseller status (0 = No, 1 = Yes)
- `bouquets_selected[]` - Array of bouquet/package IDs
- `notes` - Admin notes
- `contact` - Contact information
- `isp_lock` - Lock to specific IP address

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=create_line" \
  -d "username=newuser" \
  -d "password=securepass123" \
  -d "max_connections=1" \
  -d "exp_date=2025-12-31" \
  -d "bouquets_selected[]=1" \
  -d "bouquets_selected[]=2" \
  -d "notes=Premium customer"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "line_id": "456",
    "username": "newuser",
    "password": "securepass123"
  }
}
```

---

## ✏️ Edit Existing Line

### Action: `edit_line`

Modify settings of an existing subscription line.

**Required Parameters:**
- `id` - Line ID to edit

**Optional Parameters:**
- `username` - New username
- `password` - New password
- `max_connections` - Update connection limit
- `exp_date` - Update expiration date
- `is_trial` - Update trial status
- `bouquets_selected[]` - Update assigned packages
- `notes` - Update notes

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=edit_line" \
  -d "id=123" \
  -d "password=newpassword456" \
  -d "max_connections=2" \
  -d "exp_date=2026-06-30"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "message": "Line updated successfully"
  }
}
```

---

## 🗑️ Delete Line

### Action: `delete_line`

Permanently remove a subscription line from the panel.

⚠️ **Warning:** This action cannot be undone!

**Required Parameters:**
- `id` - Line ID to delete

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=delete_line" \
  -d "id=123"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "message": "Line deleted successfully"
  }
}
```

---

## ✅ Enable Line

### Action: `enable_line`

Activate a previously disabled line.

**Required Parameters:**
- `id` - Line ID to enable

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=enable_line" \
  -d "id=123"
```

---

## ⛔ Disable Line

### Action: `disable_line`

Temporarily suspend a line without deleting it.

**Required Parameters:**
- `id` - Line ID to disable

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=disable_line" \
  -d "id=123"
```

---

## 🚫 Ban Line

### Action: `ban_line`

Permanently block an abusive or fraudulent account.

**Required Parameters:**
- `id` - Line ID to ban

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=ban_line" \
  -d "id=123"
```

---

## ✓ Unban Line

### Action: `unban_line`

Remove ban from a previously banned line.

**Required Parameters:**
- `id` - Line ID to unban

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=unban_line" \
  -d "id=123"
```

---

## 💻 Code Examples

### Python

```python
import requests
from datetime import datetime, timedelta

class XUILineManager:
    def __init__(self, base_url, api_key):
        self.base_url = base_url
        self.api_key = api_key
    
    def _make_request(self, action, data=None):
        """Make API request"""
        params = {
            "api_key": self.api_key,
            "action": action
        }
        
        if data:
            response = requests.post(self.base_url, params=params, data=data)
        else:
            response = requests.get(self.base_url, params=params)
        
        result = response.json()
        if result["status"] != "STATUS_SUCCESS":
            raise Exception(f"API Error: {result.get('error', 'Unknown error')}")
        
        return result["data"]
    
    def get_line(self, line_id):
        """Get specific line details"""
        return self._make_request("get_line", {"id": line_id})
    
    def create_line(self, username, password, **kwargs):
        """Create new subscription line"""
        data = {
            "username": username,
            "password": password,
            **kwargs
        }
        return self._make_request("create_line", data)
    
    def edit_line(self, line_id, **kwargs):
        """Edit existing line"""
        data = {"id": line_id, **kwargs}
        return self._make_request("edit_line", data)
    
    def delete_line(self, line_id):
        """Delete line"""
        return self._make_request("delete_line", {"id": line_id})
    
    def enable_line(self, line_id):
        """Enable line"""
        return self._make_request("enable_line", {"id": line_id})
    
    def disable_line(self, line_id):
        """Disable line"""
        return self._make_request("disable_line", {"id": line_id})
    
    def ban_line(self, line_id):
        """Ban line"""
        return self._make_request("ban_line", {"id": line_id})
    
    def unban_line(self, line_id):
        """Unban line"""
        return self._make_request("unban_line", {"id": line_id})

# Usage Example
manager = XUILineManager(
    base_url="http://your-server.com/cSbuFLhp/",
    api_key="8D3135D30437F86EAE2FA4A2A8345000"
)

# Create new line
new_line = manager.create_line(
    username="customer001",
    password="secure123",
    max_connections=1,
    exp_date="2025-12-31",
    bouquets_selected=[1, 2, 3],
    notes="Premium customer"
)
print(f"Created line ID: {new_line['line_id']}")

# Get line details
line = manager.get_line(123)
print(f"Line: {line['username']} - Expires: {line['exp_date']}")

# Edit line
manager.edit_line(
    line_id=123,
    password="newpassword",
    max_connections=2
)
print("Line updated successfully")

# Disable line
manager.disable_line(123)
print("Line disabled")
```

---

### PHP

```php
<?php
class XUILineManager {
    private $baseUrl;
    private $apiKey;
    
    public function __construct($baseUrl, $apiKey) {
        $this->baseUrl = $baseUrl;
        $this->apiKey = $apiKey;
    }
    
    private function makeRequest($action, $data = null) {
        $url = $this->baseUrl . "?api_key=" . $this->apiKey . "&action=" . $action;
        
        if ($data) {
            $options = [
                'http' => [
                    'method' => 'POST',
                    'header' => 'Content-type: application/x-www-form-urlencoded',
                    'content' => http_build_query($data)
                ]
            ];
            $context = stream_context_create($options);
            $response = file_get_contents($url, false, $context);
        } else {
            $response = file_get_contents($url);
        }
        
        $result = json_decode($response, true);
        
        if ($result['status'] !== 'STATUS_SUCCESS') {
            throw new Exception("API Error: " . ($result['error'] ?? 'Unknown error'));
        }
        
        return $result['data'];
    }
    
    public function getLine($lineId) {
        return $this->makeRequest("get_line", ["id" => $lineId]);
    }
    
    public function createLine($username, $password, $options = []) {
        $data = array_merge([
            "username" => $username,
            "password" => $password
        ], $options);
        
        return $this->makeRequest("create_line", $data);
    }
    
    public function editLine($lineId, $updates) {
        $data = array_merge(["id" => $lineId], $updates);
        return $this->makeRequest("edit_line", $data);
    }
    
    public function deleteLine($lineId) {
        return $this->makeRequest("delete_line", ["id" => $lineId]);
    }
    
    public function enableLine($lineId) {
        return $this->makeRequest("enable_line", ["id" => $lineId]);
    }
    
    public function disableLine($lineId) {
        return $this->makeRequest("disable_line", ["id" => $lineId]);
    }
}

// Usage Example
$manager = new XUILineManager(
    "http://your-server.com/cSbuFLhp/",
    "8D3135D30437F86EAE2FA4A2A8345000"
);

// Create new line
$newLine = $manager->createLine(
    "customer001",
    "secure123",
    [
        "max_connections" => 1,
        "exp_date" => "2025-12-31",
        "notes" => "Premium customer"
    ]
);
echo "Created line ID: " . $newLine['line_id'] . "\n";

// Edit line
$manager->editLine(123, [
    "password" => "newpassword",
    "max_connections" => 2
]);
echo "Line updated successfully\n";
?>
```

---

### JavaScript (Node.js)

```javascript
const fetch = require('node-fetch');

class XUILineManager {
    constructor(baseUrl, apiKey) {
        this.baseUrl = baseUrl;
        this.apiKey = apiKey;
    }
    
    async makeRequest(action, data = null) {
        const url = `${this.baseUrl}?api_key=${this.apiKey}&action=${action}`;
        
        const options = {
            method: data ? 'POST' : 'GET',
        };
        
        if (data) {
            const formData = new URLSearchParams();
            for (const [key, value] of Object.entries(data)) {
                if (Array.isArray(value)) {
                    value.forEach(v => formData.append(`${key}[]`, v));
                } else {
                    formData.append(key, value);
                }
            }
            options.body = formData;
        }
        
        const response = await fetch(url, options);
        const result = await response.json();
        
        if (result.status !== 'STATUS_SUCCESS') {
            throw new Error(`API Error: ${result.error || 'Unknown error'}`);
        }
        
        return result.data;
    }
    
    async getLine(lineId) {
        const url = `${this.baseUrl}?api_key=${this.apiKey}&action=get_line&id=${lineId}`;
        const response = await fetch(url);
        const result = await response.json();
        
        if (result.status !== 'STATUS_SUCCESS') {
            throw new Error(`API Error: ${result.error || 'Unknown error'}`);
        }
        
        return result.data;
    }
    
    async createLine(username, password, options = {}) {
        const data = { username, password, ...options };
        return this.makeRequest('create_line', data);
    }
    
    async editLine(lineId, updates) {
        const data = { id: lineId, ...updates };
        return this.makeRequest('edit_line', data);
    }
    
    async deleteLine(lineId) {
        return this.makeRequest('delete_line', { id: lineId });
    }
    
    async enableLine(lineId) {
        return this.makeRequest('enable_line', { id: lineId });
    }
    
    async disableLine(lineId) {
        return this.makeRequest('disable_line', { id: lineId });
    }
    
    async banLine(lineId) {
        return this.makeRequest('ban_line', { id: lineId });
    }
    
    async unbanLine(lineId) {
        return this.makeRequest('unban_line', { id: lineId });
    }
}

// Usage Example
(async () => {
    const manager = new XUILineManager(
        'http://your-server.com/cSbuFLhp/',
        '8D3135D30437F86EAE2FA4A2A8345000'
    );
    
    try {
        // Create new line
        const newLine = await manager.createLine(
            'customer001',
            'secure123',
            {
                max_connections: 1,
                exp_date: '2025-12-31',
                bouquets_selected: [1, 2, 3],
                notes: 'Premium customer'
            }
        );
        console.log('Created line ID:', newLine.line_id);
        
        // Get line details
        const line = await manager.getLine(123);
        console.log('Line:', line.username, '- Expires:', line.exp_date);
        
        // Edit line
        await manager.editLine(123, {
            password: 'newpassword',
            max_connections: 2
        });
        console.log('Line updated successfully');
        
    } catch (error) {
        console.error('Error:', error.message);
    }
})();
```

---

## 🎯 Common Use Cases

### 1. Bulk Create Lines

```python
def bulk_create_lines(manager, count=10, package_ids=[1,2,3]):
    """Create multiple lines at once"""
    import random
    import string
    
    created_lines = []
    
    for i in range(count):
        # Generate random credentials
        username = f"user{''.join(random.choices(string.digits, k=6))}"
        password = ''.join(random.choices(string.ascii_letters + string.digits, k=12))
        
        try:
            result = manager.create_line(
                username=username,
                password=password,
                max_connections=1,
                exp_date="1month",  # 1 month from now
                bouquets_selected=package_ids
            )
            
            created_lines.append({
                'id': result['line_id'],
                'username': username,
                'password': password
            })
            
            print(f"✓ Created: {username}")
            
        except Exception as e:
            print(f"✗ Failed to create line {i+1}: {e}")
    
    return created_lines
```

### 2. Auto-Disable Expired Lines

```python
from datetime import datetime

def disable_expired_lines(manager):
    """Automatically disable lines that have expired"""
    # Get all lines
    response = requests.get(
        manager.base_url,
        params={"api_key": manager.api_key, "action": "get_lines"}
    )
    lines = response.json()['data']
    
    now = datetime.now().timestamp()
    expired_count = 0
    
    for line in lines:
        exp_date = int(line['exp_date'])
        
        # Check if expired and still enabled
        if exp_date < now and line['enabled'] == '1':
            try:
                manager.disable_line(line['id'])
                print(f"✓ Disabled expired line: {line['username']}")
                expired_count += 1
            except Exception as e:
                print(f"✗ Failed to disable {line['username']}: {e}")
    
    print(f"\nDisabled {expired_count} expired lines")
```

### 3. Reset Password for Line

```python
import secrets
import string

def reset_line_password(manager, line_id):
    """Generate and set a new secure password"""
    # Generate secure password
    alphabet = string.ascii_letters + string.digits
    new_password = ''.join(secrets.choice(alphabet) for i in range(16))
    
    # Update line
    manager.edit_line(line_id, password=new_password)
    
    return new_password

# Usage
new_pass = reset_line_password(manager, 123)
print(f"New password: {new_pass}")
```

### 4. Extend Expiration Date

```python
from datetime import datetime, timedelta

def extend_subscription(manager, line_id, months=1):
    """Extend line expiration by specified months"""
    # Get current line
    line = manager.get_line(line_id)
    
    # Calculate new expiration
    current_exp = datetime.fromtimestamp(int(line['exp_date']))
    new_exp = current_exp + timedelta(days=30 * months)
    new_exp_timestamp = int(new_exp.timestamp())
    
    # Update line
    manager.edit_line(line_id, exp_date=new_exp_timestamp)
    
    print(f"Extended to: {new_exp.strftime('%Y-%m-%d')}")
```

### 5. Upgrade Line to Different Package

```python
def upgrade_line_package(manager, line_id, new_package_ids):
    """Change line's assigned packages"""
    manager.edit_line(
        line_id,
        bouquets_selected=new_package_ids
    )
    
    print(f"Upgraded line {line_id} to packages: {new_package_ids}")

# Usage
upgrade_line_package(manager, 123, [1, 2, 3, 4, 5])  # Premium package
```

### 6. Export Line Credentials

```python
import csv

def export_lines_to_csv(manager, filename="lines_export.csv"):
    """Export all lines to CSV file"""
    # Get all lines
    response = requests.get(
        manager.base_url,
        params={"api_key": manager.api_key, "action": "get_lines"}
    )
    lines = response.json()['data']
    
    # Write to CSV
    with open(filename, 'w', newline='') as csvfile:
        fieldnames = ['id', 'username', 'password', 'exp_date', 'max_connections', 'enabled']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        writer.writeheader()
        for line in lines:
            writer.writerow({
                'id': line['id'],
                'username': line['username'],
                'password': line['password'],
                'exp_date': datetime.fromtimestamp(int(line['exp_date'])).strftime('%Y-%m-%d'),
                'max_connections': line['max_connections'],
                'enabled': 'Yes' if line['enabled'] == '1' else 'No'
            })
    
    print(f"Exported {len(lines)} lines to {filename}")
```

---

## 📊 Expiration Date Formats

XUI.ONE accepts multiple formats for expiration dates:

### 1. Specific Date (YYYY-MM-DD)
```bash
-d "exp_date=2025-12-31"
```

### 2. Unix Timestamp
```bash
-d "exp_date=1735689600"
```

### 3. Relative Time
```bash
# Hours
-d "exp_date=24hours"

# Days
-d "exp_date=7days"

# Months
-d "exp_date=1month"
-d "exp_date=3months"

# Years
-d "exp_date=1year"
```

### Python Helper Function

```python
from datetime import datetime, timedelta

def format_exp_date(days=None, months=None, years=None, date=None):
    """Convert various formats to Unix timestamp"""
    if date:
        # Specific date
        dt = datetime.strptime(date, '%Y-%m-%d')
    else:
        # Relative date
        dt = datetime.now()
        if days:
            dt += timedelta(days=days)
        if months:
            dt += timedelta(days=30 * months)
        if years:
            dt += timedelta(days=365 * years)
    
    return int(dt.timestamp())

# Usage
exp_date = format_exp_date(months=3)  # 3 months from now
```

---

## ⚠️ Important Notes

### Username/Password Requirements

- **Username:** 3-50 characters, alphanumeric
- **Password:** Minimum 6 characters recommended
- **No special characters** in username (use only letters, numbers, underscore)

### Bouquet Selection

When assigning bouquets, use array notation:
```bash
# cURL
-d "bouquets_selected[]=1" \
-d "bouquets_selected[]=2"

# Python
bouquets_selected=[1, 2, 3]

# PHP
["bouquets_selected" => [1, 2, 3]]
```

### Max Connections

- **Minimum:** 1
- **Maximum:** Unlimited (but reasonable limits recommended)
- **Common values:** 1-5 for home users, 10-50 for resellers

### Trial vs. Regular Lines

Trial lines can be automatically converted to regular lines:
```python
# Create trial
manager.create_line(
    username="trial001",
    password="temp123",
    is_trial=1,
    exp_date="7days"
)

# Convert to regular (when customer pays)
manager.edit_line(
    line_id=123,
    is_trial=0,
    exp_date="1year"
)
```

---

## 💡 Best Practices

### 1. Always Check Before Delete

```python
def safe_delete_line(manager, line_id):
    """Delete line with confirmation"""
    try:
        # Get line details first
        line = manager.get_line(line_id)
        
        # Confirm it's the right line
        print(f"About to delete: {line['username']}")
        confirm = input("Are you sure? (yes/no): ")
        
        if confirm.lower() == 'yes':
            manager.delete_line(line_id)
            print("Line deleted successfully")
        else:
            print("Deletion cancelled")
            
    except Exception as e:
        print(f"Error: {e}")
```

### 2. Validate Input Data

```python
def validate_line_data(username, password, max_connections):
    """Validate line data before creation"""
    errors = []
    
    if len(username) < 3 or len(username) > 50:
        errors.append("Username must be 3-50 characters")
    
    if not username.replace('_', '').isalnum():
        errors.append("Username must be alphanumeric")
    
    if len(password) < 6:
        errors.append("Password must be at least 6 characters")
    
    if max_connections < 1:
        errors.append("Max connections must be at least 1")
    
    return errors

# Usage
errors = validate_line_data("user123", "pass", 1)
if errors:
    print("Validation errors:")
    for error in errors:
        print(f"  - {error}")
else:
    # Create line
    manager.create_line("user123", "secure123", max_connections=1)
```

### 3. Implement Rate Limiting

```python
import time
from functools import wraps

def rate_limit(calls_per_second=2):
    """Limit API calls to prevent overload"""
    min_interval = 1.0 / calls_per_second
    last_called = [0.0]
    
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            elapsed = time.time() - last_called[0]
            left_to_wait = min_interval - elapsed
            
            if left_to_wait > 0:
                time.sleep(left_to_wait)
            
            result = func(*args, **kwargs)
            last_called[0] = time.time()
            return result
        return wrapper
    return decorator

# Apply to methods
XUILineManager.create_line = rate_limit()(XUILineManager.create_line)
```

### 4. Error Handling

```python
def create_line_with_retry(manager, username, password, retries=3):
    """Create line with automatic retry on failure"""
    for attempt in range(retries):
        try:
            return manager.create_line(username, password)
        except Exception as e:
            if attempt < retries - 1:
                print(f"Attempt {attempt + 1} failed: {e}. Retrying...")
                time.sleep(2 ** attempt)  # Exponential backoff
            else:
                print(f"All {retries} attempts failed")
                raise
```

---

## 📚 Related Documentation

- [GET INFO API - Query Lines](02-get-info.md#1-get-all-subscription-lines)
- [Authentication Guide](../authentication.md)
- [Error Handling](../error-codes.md)

---

## 🆘 Need Help?

- **GitHub Issues:** [Report problems](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
- **Community:** [World of IPTV Forums](https://www.worldofiptv.com)
- **Documentation:** [Getting Started Guide](../getting-started.md)
