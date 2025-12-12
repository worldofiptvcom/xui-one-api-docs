# MAG API - MAG Device Management

Complete documentation for MAG set-top box device management in the XUI.ONE Admin API.

## 📋 Overview

The MAG API provides complete control over MAG device subscriptions. Manage MAG boxes, assign packages, control status, and convert devices to standard M3U lines.

### Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_mag` | POST | Create MAG device |
| `edit_mag` | POST | Edit MAG settings |
| `delete_mag` | POST | Remove MAG device |
| `enable_mag` | POST | Activate MAG device |
| `disable_mag` | POST | Suspend MAG device |
| `ban_mag` | POST | Ban MAG device |
| `unban_mag` | POST | Unban MAG device |
| `convert_mag_to_line` | POST | Convert to M3U line |
| `get_mag` | GET | Get MAG details |

---

## ➕ Create MAG Device

### Action: `create_mag`

Create a new MAG device subscription.

**Required Parameters:**
- `mac` - MAC address of the MAG device

**Optional Parameters:**
- `exp_date` - Expiration date
- `bouquets_selected[]` - Package IDs to assign
- `notes` - Admin notes

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=create_mag" \
  -d "mac=00:1A:79:XX:XX:XX" \
  -d "exp_date=2025-12-31" \
  -d "bouquets_selected[]=1" \
  -d "bouquets_selected[]=2" \
  -d "notes=Customer MAG device"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "mag_id": "202",
    "mac": "00:1A:79:XX:XX:XX"
  }
}
```

---

## ✏️ Edit MAG Device

### Action: `edit_mag`

Modify existing MAG device settings.

**Required Parameters:**
- `id` - MAG device ID

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=edit_mag" \
  -d "id=202" \
  -d "exp_date=2026-12-31"
```

---

## 🔄 Convert MAG to Line

### Action: `convert_mag_to_line`

Convert MAG device subscription to standard M3U/Xtream line.

**Required Parameters:**
- `id` - MAG device ID

**Request:**
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=convert_mag_to_line" \
  -d "id=202"
```

**Response:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "line_id": "456",
    "username": "converted_user",
    "password": "generated_pass"
  }
}
```

---

## 💻 Code Examples

### Python - Complete MAG Manager

```python
import requests

class XUIMAGManager:
    def __init__(self, base_url, api_key):
        self.base_url = base_url
        self.api_key = api_key
    
    def _request(self, action, data=None, method='POST'):
        params = {'api_key': self.api_key, 'action': action}
        
        if method == 'POST' and data:
            response = requests.post(self.base_url, params=params, data=data)
        else:
            if data:
                params.update(data)
            response = requests.get(self.base_url, params=params)
        
        result = response.json()
        if result.get('status') != 'STATUS_SUCCESS':
            raise Exception(f"API Error: {result.get('error')}")
        
        return result.get('data')
    
    def create_mag(self, mac, exp_date=None, packages=None, notes=None):
        """Create MAG device"""
        data = {'mac': mac}
        
        if exp_date:
            data['exp_date'] = exp_date
        if packages:
            data['bouquets_selected'] = packages
        if notes:
            data['notes'] = notes
        
        return self._request('create_mag', data)
    
    def edit_mag(self, mag_id, **updates):
        """Edit MAG device"""
        data = {'id': mag_id, **updates}
        return self._request('edit_mag', data)
    
    def delete_mag(self, mag_id):
        """Delete MAG device"""
        return self._request('delete_mag', {'id': mag_id})
    
    def enable_mag(self, mag_id):
        """Enable MAG device"""
        return self._request('enable_mag', {'id': mag_id})
    
    def disable_mag(self, mag_id):
        """Disable MAG device"""
        return self._request('disable_mag', {'id': mag_id})
    
    def ban_mag(self, mag_id):
        """Ban MAG device"""
        return self._request('ban_mag', {'id': mag_id})
    
    def unban_mag(self, mag_id):
        """Unban MAG device"""
        return self._request('unban_mag', {'id': mag_id})
    
    def convert_to_line(self, mag_id):
        """Convert MAG to M3U line"""
        return self._request('convert_mag_to_line', {'id': mag_id})
    
    def get_mag(self, mag_id):
        """Get MAG device details"""
        return self._request('get_mag', {'id': mag_id}, method='GET')

# Usage
manager = XUIMAGManager(
    'http://your-server.com/cSbuFLhp/',
    '8D3135D30437F86EAE2FA4A2A8345000'
)

# Create MAG device
result = manager.create_mag(
    mac='00:1A:79:XX:XX:XX',
    exp_date='2025-12-31',
    packages=[1, 2, 3],
    notes='Premium customer'
)
print(f"Created MAG ID: {result['mag_id']}")

# Convert to line
line_data = manager.convert_to_line(202)
print(f"Converted to line: {line_data['username']}/{line_data['password']}")
```

---

## 🎯 Common Use Cases

### 1. Bulk MAG Device Registration

```python
def bulk_register_mags(manager, mac_addresses, package_ids, exp_date='1year'):
    """Register multiple MAG devices at once"""
    results = []
    
    for mac in mac_addresses:
        try:
            result = manager.create_mag(
                mac=mac,
                exp_date=exp_date,
                packages=package_ids
            )
            results.append({
                'mac': mac,
                'mag_id': result['mag_id'],
                'status': 'success'
            })
            print(f"✓ Registered: {mac}")
            
        except Exception as e:
            results.append({
                'mac': mac,
                'status': 'failed',
                'error': str(e)
            })
            print(f"✗ Failed: {mac} - {e}")
    
    return results

# Usage
macs = [
    '00:1A:79:11:11:11',
    '00:1A:79:22:22:22',
    '00:1A:79:33:33:33'
]

results = bulk_register_mags(manager, macs, [1, 2, 3])
```

### 2. MAG Migration to Lines

```python
def migrate_mags_to_lines(manager):
    """Convert all MAG devices to M3U lines"""
    # Get all MAG devices
    mags = manager._request('get_mags', {}, method='GET')
    
    converted = []
    failed = []
    
    for mag in mags:
        try:
            result = manager.convert_to_line(mag['id'])
            converted.append({
                'mag_id': mag['id'],
                'mac': mag['mac'],
                'line_id': result['line_id'],
                'credentials': f"{result['username']}:{result['password']}"
            })
            print(f"✓ Converted MAG {mag['mac']} to line {result['line_id']}")
            
        except Exception as e:
            failed.append({
                'mag_id': mag['id'],
                'error': str(e)
            })
            print(f"✗ Failed to convert MAG {mag['mac']}: {e}")
    
    return {'converted': converted, 'failed': failed}
```

### 3. MAG Device Status Monitor

```python
def monitor_mag_status(manager):
    """Monitor and report MAG device status"""
    mags = manager._request('get_mags', {}, method='GET')
    
    status_report = {
        'total': len(mags),
        'active': 0,
        'disabled': 0,
        'banned': 0,
        'expiring_soon': 0
    }
    
    from datetime import datetime, timedelta
    threshold = datetime.now() + timedelta(days=7)
    
    for mag in mags:
        if mag.get('enabled') == '1':
            status_report['active'] += 1
        else:
            status_report['disabled'] += 1
        
        if mag.get('is_banned') == '1':
            status_report['banned'] += 1
        
        exp_date = datetime.fromtimestamp(int(mag['exp_date']))
        if exp_date <= threshold:
            status_report['expiring_soon'] += 1
    
    print("MAG Device Status Report")
    print("=" * 50)
    for key, value in status_report.items():
        print(f"{key.replace('_', ' ').title()}: {value}")
```

---

## 💡 Best Practices

### 1. MAC Address Validation

```python
import re

def validate_mac_address(mac):
    """Validate MAC address format"""
    # Standard format: XX:XX:XX:XX:XX:XX
    pattern = r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'
    return bool(re.match(pattern, mac))

def create_mag_safe(manager, mac, **kwargs):
    """Create MAG with validation"""
    if not validate_mac_address(mac):
        raise ValueError(f"Invalid MAC address format: {mac}")
    
    # Normalize MAC address to uppercase with colons
    mac = mac.upper().replace('-', ':')
    
    return manager.create_mag(mac, **kwargs)
```

### 2. MAC Address Normalization

```python
def normalize_mac(mac):
    """Normalize MAC address format"""
    # Remove separators and convert to uppercase
    clean = mac.replace(':', '').replace('-', '').upper()
    
    # Add colons every 2 characters
    return ':'.join(clean[i:i+2] for i in range(0, 12, 2))

# Examples
normalize_mac('00-1a-79-ab-cd-ef')  # → '00:1A:79:AB:CD:EF'
normalize_mac('001A79ABCDEF')       # → '00:1A:79:AB:CD:EF'
```

### 3. Batch Operations with Error Recovery

```python
def batch_update_mags(manager, updates, retry=True):
    """Update multiple MAG devices with error handling"""
    results = {'success': [], 'failed': []}
    
    for mag_id, update_data in updates.items():
        attempt = 0
        max_attempts = 3 if retry else 1
        
        while attempt < max_attempts:
            try:
                manager.edit_mag(mag_id, **update_data)
                results['success'].append(mag_id)
                print(f"✓ Updated MAG {mag_id}")
                break
                
            except Exception as e:
                attempt += 1
                if attempt >= max_attempts:
                    results['failed'].append({
                        'mag_id': mag_id,
                        'error': str(e)
                    })
                    print(f"✗ Failed MAG {mag_id}: {e}")
                else:
                    print(f"Retry {attempt}/{max_attempts} for MAG {mag_id}")
                    time.sleep(1)
    
    return results
```

---

## ⚠️ Important Notes

### MAC Address Format
- Standard format: `XX:XX:XX:XX:XX:XX`
- Must be unique per device
- Case-insensitive (automatically normalized)

### Device Conversion
- Converting MAG to line is **permanent**
- Original MAG device will be removed
- New line credentials are auto-generated
- Packages/expiration are preserved

### Supported MAG Models
- MAG 250/254/256/322/324/349/351/352/410/424
- Aura HD/HD Plus
- Compatible with most Linux-based STBs

---

## 📚 Related Documentation

- [GET INFO API - Query MAG Devices](02-get-info.md#8-get-all-mag-devices)
- [MAG Events Logs](04-logs-events.md#-mag-events)
- [Line API](03-line-api.md)

---

## 🆘 Need Help?

- **GitHub Issues:** [Report problems](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
- **Community:** [World of IPTV Forums](https://www.worldofiptv.com)
- **Documentation:** [Getting Started Guide](../getting-started.md)
