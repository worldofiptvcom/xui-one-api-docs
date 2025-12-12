# Settings & System API - Panel Configuration

Panel settings and system management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `get_settings` | GET | Get panel settings |
| `edit_settings` | POST | Update panel settings |
| `reload_nginx` | POST | Reload nginx configuration |
| `clear_cache` | POST | Clear system cache |
| `backup_database` | POST | Backup database |
| `restore_database` | POST | Restore database |
| `get_categories` | GET | Get all categories |
| `create_category` | POST | Create category |
| `edit_category` | POST | Edit category |
| `delete_category` | POST | Delete category |
| `get_bouquets` | GET | Get all bouquets/packages |
| `create_bouquet` | POST | Create bouquet |
| `edit_bouquet` | POST | Edit bouquet |
| `delete_bouquet` | POST | Delete bouquet |

---

## Quick Examples

### System Maintenance
```bash
# Backup database
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=backup_database"

# Clear cache
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=clear_cache"

# Reload nginx
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=reload_nginx"
```

### Category Management
```bash
# Create category
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_category" \
  -d "category_name=Sports" \
  -d "category_type=live"

# Get all categories
curl "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=get_categories"
```

### Bouquet Management
```bash
# Create bouquet
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_bouquet" \
  -d "package_name=Premium Package" \
  -d "streams=[1,2,3,4,5]" \
  -d "price=29.99"

# Get all bouquets
curl "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=get_bouquets"
```

---

## Python Automation Example

```python
def daily_maintenance(manager):
    """Automated daily maintenance tasks"""
    print("Starting daily maintenance...")
    
    # Backup database
    print("- Backing up database...")
    manager._request('backup_database', method='POST')
    
    # Clear cache
    print("- Clearing cache...")
    manager._request('clear_cache', method='POST')
    
    # Get system status
    print("- Checking system status...")
    settings = manager._request('get_settings', method='GET')
    
    print("✓ Daily maintenance completed")
    return settings

def organize_content(manager):
    """Organize content into categories"""
    # Create categories
    categories = [
        {'name': 'Sports', 'type': 'live'},
        {'name': 'News', 'type': 'live'},
        {'name': 'Movies', 'type': 'vod'},
        {'name': 'TV Shows', 'type': 'series'}
    ]
    
    for cat in categories:
        try:
            manager._request('create_category', {
                'category_name': cat['name'],
                'category_type': cat['type']
            }, method='POST')
            print(f"✓ Created category: {cat['name']}")
        except Exception as e:
            print(f"✗ Failed to create {cat['name']}: {e}")
```

---

## Category Types

- `live` - Live TV channels
- `vod` - Movies
- `series` - TV Series
- `radio` - Radio stations

---

## Bouquet/Package Structure

```json
{
  "package_name": "Premium Package",
  "streams": [1, 2, 3, 4, 5],
  "price": 29.99,
  "duration_days": 30,
  "description": "Full access to all channels"
}
```

---

## 📚 Related: [GET INFO API](02-get-info.md)
