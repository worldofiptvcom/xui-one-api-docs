# User API - Account Management

Complete documentation for user account management in the XUI.ONE Admin API.

## 📋 Overview

The User API provides complete control over admin, reseller, and user accounts. Manage permissions, credits, and account status programmatically.

### Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_user` | POST | Create new user account |
| `edit_user` | POST | Modify user settings |
| `delete_user` | POST | Remove user account |
| `enable_user` | POST | Activate user account |
| `disable_user` | POST | Suspend user account |
| `add_credits` | POST | Add credits to reseller |

---

## 👤 Create User

### Action: `create_user`

Create a new admin, reseller, or user account.

**Required Parameters:**
- `username` - Username for the account
- `password` - Account password

**Optional Parameters:**
- `email` - Email address
- `member_group_id` - User role (1=Admin, 2=Reseller, 3=User)

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=create_user" \
  -d "username=newreseller" \
  -d "password=secure123" \
  -d "email=reseller@example.com" \
  -d "member_group_id=2"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "user_id": "10",
    "username": "newreseller"
  }
}
```

---

## ✏️ Edit User

### Action: `edit_user`

Modify existing user account settings.

**Required Parameters:**
- `id` - User ID to edit

**Optional Parameters:**
- `username` - New username
- `password` - New password
- `email` - New email
- `member_group_id` - Change role

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=edit_user" \
  -d "id=10" \
  -d "password=newpassword456" \
  -d "email=newemail@example.com"
```

---

## 🗑️ Delete User

### Action: `delete_user`

Permanently remove user account.

⚠️ **Warning:** This action cannot be undone!

**Required Parameters:**
- `id` - User ID to delete

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=delete_user" \
  -d "id=10"
```

---

## ✅ Enable User

### Action: `enable_user`

Activate a disabled user account.

**Required Parameters:**
- `id` - User ID to enable

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=enable_user" \
  -d "id=10"
```

---

## ⛔ Disable User

### Action: `disable_user`

Temporarily suspend user account without deletion.

**Required Parameters:**
- `id` - User ID to disable

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=disable_user" \
  -d "id=10"
```

---

## 💰 Add Credits

### Action: `add_credits`

Add credits to reseller account balance.

**Parameters:**
- `user_id` - Reseller user ID
- `amount` - Credit amount to add

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=add_credits" \
  -d "user_id=10" \
  -d "amount=100.00"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "user_id": "10",
    "credits_added": "100.00",
    "new_balance": "500.00"
  }
}
```

---

## 💻 Code Examples

### Python

```python
import requests

class XUIUserManager:
    def __init__(self, base_url, api_key):
        self.base_url = base_url
        self.api_key = api_key
    
    def _request(self, action, data):
        response = requests.post(
            self.base_url,
            params={'api_key': self.api_key, 'action': action},
            data=data
        )
        return response.json()
    
    def create_user(self, username, password, email=None, role=2):
        """Create new user account"""
        data = {
            'username': username,
            'password': password,
            'member_group_id': role
        }
        if email:
            data['email'] = email
        
        return self._request('create_user', data)
    
    def edit_user(self, user_id, **updates):
        """Edit user account"""
        data = {'id': user_id, **updates}
        return self._request('edit_user', data)
    
    def delete_user(self, user_id):
        """Delete user account"""
        return self._request('delete_user', {'id': user_id})
    
    def enable_user(self, user_id):
        """Enable user account"""
        return self._request('enable_user', {'id': user_id})
    
    def disable_user(self, user_id):
        """Disable user account"""
        return self._request('disable_user', {'id': user_id})
    
    def add_credits(self, user_id, amount):
        """Add credits to reseller"""
        return self._request('add_credits', {
            'user_id': user_id,
            'amount': amount
        })

# Usage
manager = XUIUserManager(
    'http://your-server.com/cSbuFLhp/',
    '8D3135D30437F86EAE2FA4A2A8345000'
)

# Create reseller
result = manager.create_user(
    username='newreseller',
    password='secure123',
    email='reseller@example.com',
    role=2  # Reseller
)
print(f"Created user ID: {result['data']['user_id']}")

# Add credits
manager.add_credits(user_id=10, amount=100.00)
print("Credits added successfully")
```

### PHP

```php
<?php
class XUIUserManager {
    private $baseUrl;
    private $apiKey;
    
    public function __construct($baseUrl, $apiKey) {
        $this->baseUrl = $baseUrl;
        $this->apiKey = $apiKey;
    }
    
    private function request($action, $data) {
        $url = $this->baseUrl . "?api_key=" . $this->apiKey . "&action=" . $action;
        
        $options = [
            'http' => [
                'method' => 'POST',
                'header' => 'Content-type: application/x-www-form-urlencoded',
                'content' => http_build_query($data)
            ]
        ];
        
        $context = stream_context_create($options);
        $response = file_get_contents($url, false, $context);
        return json_decode($response, true);
    }
    
    public function createUser($username, $password, $email = null, $role = 2) {
        $data = [
            'username' => $username,
            'password' => $password,
            'member_group_id' => $role
        ];
        
        if ($email) {
            $data['email'] = $email;
        }
        
        return $this->request('create_user', $data);
    }
    
    public function addCredits($userId, $amount) {
        return $this->request('add_credits', [
            'user_id' => $userId,
            'amount' => $amount
        ]);
    }
}

// Usage
$manager = new XUIUserManager(
    "http://your-server.com/cSbuFLhp/",
    "8D3135D30437F86EAE2FA4A2A8345000"
);

$result = $manager->createUser(
    "newreseller",
    "secure123",
    "reseller@example.com",
    2
);

echo "Created user ID: " . $result['data']['user_id'];
?>
```

---

## 🎯 Common Use Cases

### 1. Bulk Create Resellers

```python
def bulk_create_resellers(manager, count=10, initial_credits=100):
    """Create multiple reseller accounts"""
    resellers = []
    
    for i in range(count):
        username = f"reseller{i+1:03d}"
        password = generate_secure_password()
        email = f"{username}@example.com"
        
        try:
            # Create reseller
            result = manager.create_user(
                username=username,
                password=password,
                email=email,
                role=2
            )
            
            user_id = result['data']['user_id']
            
            # Add initial credits
            manager.add_credits(user_id, initial_credits)
            
            resellers.append({
                'id': user_id,
                'username': username,
                'password': password,
                'email': email,
                'credits': initial_credits
            })
            
            print(f"✓ Created: {username}")
            
        except Exception as e:
            print(f"✗ Failed to create {username}: {e}")
    
    return resellers
```

### 2. Credit Management System

```python
def manage_reseller_credits(manager):
    """Monitor and manage reseller credits"""
    # Get all users (assuming you have get_users)
    users = manager._request('get_users', {})
    
    for user in users['data']:
        if user['member_group_id'] == '2':  # Resellers only
            credits = float(user.get('credits', 0))
            
            # Auto-add credits if balance is low
            if credits < 10:
                manager.add_credits(user['id'], 50)
                print(f"Added 50 credits to {user['username']}")
```

### 3. User Audit Report

```python
def generate_user_report(manager):
    """Generate user account report"""
    users = manager._request('get_users', {})
    
    report = {
        'total': len(users['data']),
        'admins': 0,
        'resellers': 0,
        'users': 0,
        'active': 0,
        'disabled': 0
    }
    
    for user in users['data']:
        role = int(user['member_group_id'])
        if role == 1:
            report['admins'] += 1
        elif role == 2:
            report['resellers'] += 1
        else:
            report['users'] += 1
        
        if user['status'] == '1':
            report['active'] += 1
        else:
            report['disabled'] += 1
    
    print("User Account Report")
    print("=" * 50)
    for key, value in report.items():
        print(f"{key.capitalize()}: {value}")
```

---

## 💡 Best Practices

### 1. Password Security

```python
import secrets
import string

def generate_secure_password(length=16):
    """Generate cryptographically secure password"""
    alphabet = string.ascii_letters + string.digits + "!@#$%^&*"
    return ''.join(secrets.choice(alphabet) for _ in range(length))
```

### 2. Role-Based Access Control

```python
# User roles
ROLE_ADMIN = 1
ROLE_RESELLER = 2
ROLE_USER = 3

def create_user_with_role(manager, username, password, role_name):
    """Create user with role name instead of ID"""
    roles = {
        'admin': ROLE_ADMIN,
        'reseller': ROLE_RESELLER,
        'user': ROLE_USER
    }
    
    role_id = roles.get(role_name.lower(), ROLE_USER)
    
    return manager.create_user(
        username=username,
        password=password,
        role=role_id
    )
```

### 3. Email Validation

```python
import re

def validate_email(email):
    """Validate email format"""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

def create_user_safe(manager, username, password, email):
    """Create user with validation"""
    if not validate_email(email):
        raise ValueError("Invalid email format")
    
    if len(password) < 8:
        raise ValueError("Password must be at least 8 characters")
    
    return manager.create_user(username, password, email)
```

---

## ⚠️ Important Notes

### Username Requirements
- 3-50 characters
- Alphanumeric characters only
- Must be unique

### Password Requirements
- Minimum 6 characters (8+ recommended)
- Mix of letters, numbers, symbols recommended

### User Roles
- **1 = Admin** - Full panel access
- **2 = Reseller** - Can create/manage lines
- **3 = User** - Limited access

### Credit System
- Credits are decimal values (e.g., 100.00)
- Used by resellers to create subscriptions
- Can be added but not deducted via API

---

## 📚 Related Documentation

- [GET INFO API - Query Users](02-get-info.md#2-get-all-users)
- [Credit Logs](04-logs-events.md#-credit-logs)
- [Authentication Guide](../getting-started.md)

---

## 🆘 Need Help?

- **GitHub Issues:** [Report problems](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
- **Community:** [World of IPTV Forums](https://www.worldofiptv.com)
- **Documentation:** [Getting Started Guide](../getting-started.md)
