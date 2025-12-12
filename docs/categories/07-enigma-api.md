# Enigma API - Enigma2 Device Management

Complete documentation for Enigma2 STB device management in the XUI.ONE Admin API.

## 📋 Overview

The Enigma API provides complete control over Enigma2 set-top box subscriptions. Similar to MAG API but for Enigma2-based devices.

### Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_enigma` | POST | Create Enigma2 device |
| `edit_enigma` | POST | Edit Enigma2 settings |
| `delete_enigma` | POST | Remove Enigma2 device |
| `enable_enigma` | POST | Activate Enigma2 device |
| `disable_enigma` | POST | Suspend Enigma2 device |
| `ban_enigma` | POST | Ban Enigma2 device |
| `unban_enigma` | POST | Unban Enigma2 device |
| `convert_enigma_to_line` | POST | Convert to M3U line |
| `get_enigma` | GET | Get Enigma2 details |

---

## Quick Examples

### Create Enigma2 Device
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_enigma" \
  -d "mac=00:1A:79:YY:YY:YY" \
  -d "exp_date=2025-12-31" \
  -d "bouquets_selected[]=1"
```

### Convert to Line
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=convert_enigma_to_line" \
  -d "id=303"
```

---

## Python Example

```python
class XUIEnigmaManager:
    def __init__(self, base_url, api_key):
        self.base_url = base_url
        self.api_key = api_key
    
    def create_enigma(self, mac, exp_date=None, packages=None):
        data = {'mac': mac}
        if exp_date:
            data['exp_date'] = exp_date
        if packages:
            data['bouquets_selected'] = packages
        
        response = requests.post(
            self.base_url,
            params={'api_key': self.api_key, 'action': 'create_enigma'},
            data=data
        )
        return response.json()
    
    def convert_to_line(self, enigma_id):
        response = requests.post(
            self.base_url,
            params={'api_key': self.api_key, 'action': 'convert_enigma_to_line'},
            data={'id': enigma_id}
        )
        return response.json()

# Usage
manager = XUIEnigmaManager('http://your-server.com/cSbuFLhp/', 'API_KEY')
result = manager.create_enigma('00:1A:79:YY:YY:YY', '2025-12-31', [1, 2])
```

---

## Supported Devices

- Enigma2-based STBs
- Dreambox
- VU+
- Gigablue
- Octagon
- Most Linux-based satellite receivers

---

## ⚠️ Important Notes

- MAC address format: `XX:XX:XX:XX:XX:XX`
- Conversion to line is permanent
- All operations identical to MAG API
- Packages and expiration preserved on conversion

---

## 📚 Related Documentation

- [GET INFO API - Query Enigma Devices](02-get-info.md#9-get-all-enigma2-devices)
- [MAG API](06-mag-api.md) - Similar functionality
- [Line API](03-line-api.md)
