# GET INFO / Query Actions

Complete documentation for all data retrieval endpoints in the XUI.ONE Admin API.

## 📋 Overview

GET INFO endpoints allow you to retrieve information about your XUI.ONE panel resources without making modifications. These are **read-only operations** that return data in JSON format.

### Available Endpoints

| Endpoint | Description | Returns |
|----------|-------------|---------|
| `get_lines` | Get all subscription lines | Array of line objects |
| `get_users` | Get all user accounts | Array of user objects |
| `get_streams` | Get all live streams | Array of stream objects |
| `get_channels` | Get all channels | Array of channel objects |
| `get_movies` | Get all VOD movies | Array of movie objects |
| `get_series_list` | Get all TV series | Array of series objects |
| `get_episodes` | Get all episodes | Array of episode objects |
| `get_mags` | Get all MAG devices | Array of MAG objects |
| `get_enigmas` | Get all Enigma2 devices | Array of Enigma2 objects |
| `get_stations` | Get all radio stations | Array of station objects |
| `get_packages` | Get all subscription packages | Array of package objects |

---

## 🔍 Common Usage Patterns

### Basic Query

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=ACTION_NAME"
```

### With Pagination (where supported)

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=ACTION_NAME&limit=100&offset=0"
```

### With Filtering (where supported)

```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_episodes&series_id=123"
```

---

## 📝 Detailed Endpoint Documentation

### 1. Get All Subscription Lines

**Action:** `get_lines`

**Description:** Retrieves all subscription lines (M3U/Xtream Codes accounts) in your panel.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_lines"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
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
  ]
}
```

**Use Cases:**
- Monitor active subscriptions
- Check expiration dates
- Export customer list
- View connection limits
- Audit trial accounts

---

### 2. Get All Users

**Action:** `get_users`

**Description:** Retrieves all user accounts (admins, resellers, users) in your panel.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_users"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
      "id": "1",
      "username": "admin",
      "member_group_id": "1",
      "email": "admin@example.com",
      "date_registered": "1609459200",
      "status": "1"
    }
  ]
}
```

**Use Cases:**
- List all panel users
- Audit user permissions
- View reseller accounts
- Export user data

---

### 3. Get All Live Streams

**Action:** `get_streams`

**Description:** Retrieves all live TV streams configured in your panel.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_streams"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
      "id": "456",
      "stream_display_name": "CNN HD",
      "stream_source": "http://source.example.com/stream.m3u8",
      "category_id": "1",
      "stream_icon": "http://example.com/icon.png",
      "enabled": "1"
    }
  ]
}
```

**Use Cases:**
- List all streams
- Check stream status
- Monitor stream sources
- Export stream configurations
- View stream categories

---

### 4. Get All Channels

**Action:** `get_channels`

**Description:** Retrieves all channel configurations.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_channels"
```

**Use Cases:**
- List channel catalog
- View EPG mappings
- Export channel list
- Check channel categories

---

### 5. Get All Movies

**Action:** `get_movies`

**Description:** Retrieves all VOD movies in your panel.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_movies"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
      "id": "789",
      "name": "The Matrix",
      "stream_type": "movie",
      "added": "1609459200",
      "category_id": "5",
      "cover": "http://example.com/poster.jpg",
      "plot": "A computer hacker learns..."
    }
  ]
}
```

**Use Cases:**
- List movie catalog
- View movie metadata
- Monitor storage usage
- Export movie list
- Check categories

---

### 6. Get All Series

**Action:** `get_series_list`

**Description:** Retrieves all TV series in your panel.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_series_list"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
      "id": "101",
      "name": "Breaking Bad",
      "category_id": "3",
      "cover": "http://example.com/cover.jpg",
      "plot": "A high school chemistry teacher...",
      "num_seasons": "5"
    }
  ]
}
```

**Use Cases:**
- List series catalog
- View series metadata
- Check episode counts
- Export series list

---

### 7. Get All Episodes

**Action:** `get_episodes`

**Description:** Retrieves all episodes. Can be filtered by series.

**Request (All Episodes):**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_episodes"
```

**Request (Specific Series):**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_episodes&series_id=101"
```

**Parameters:**
- `series_id` (optional) - Filter by series ID

**Use Cases:**
- List all episodes
- View episode metadata
- Filter by series
- Check availability

---

### 8. Get All MAG Devices

**Action:** `get_mags`

**Description:** Retrieves all MAG set-top box subscriptions.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_mags"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
      "id": "202",
      "mac": "00:1A:79:XX:XX:XX",
      "exp_date": "1735689600",
      "enabled": "1",
      "bouquet": "[1,2,3]"
    }
  ]
}
```

**Use Cases:**
- List MAG devices
- View MAC addresses
- Check expiration dates
- Monitor device status

---

### 9. Get All Enigma2 Devices

**Action:** `get_enigmas`

**Description:** Retrieves all Enigma2 STB subscriptions.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_enigmas"
```

**Use Cases:**
- List Enigma2 devices
- View device status
- Check expiration dates
- Monitor connections

---

### 10. Get All Radio Stations

**Action:** `get_stations`

**Description:** Retrieves all radio streaming channels.

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_stations"
```

**Use Cases:**
- List radio stations
- View station metadata
- Check stream sources
- Export station list

---

### 11. Get All Packages

**Action:** `get_packages`

**Description:** Retrieves all subscription packages (bouquets).

**Request:**
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=8D3135D30437F86EAE2FA4A2A8345000&action=get_packages"
```

**Response Example:**
```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    {
      "id": "1",
      "package_name": "Premium Package",
      "streams": "[1,2,3,4,5]",
      "bouquet_channels": "100"
    }
  ]
}
```

**Use Cases:**
- List all packages
- View package configurations
- Check channel assignments
- Export package data

---

## 💻 Code Examples

### Python

```python
import requests

# Configuration
BASE_URL = "http://your-server.com/cSbuFLhp/"
API_KEY = "8D3135D30437F86EAE2FA4A2A8345000"

def get_lines():
    """Get all subscription lines"""
    response = requests.get(
        BASE_URL,
        params={
            "api_key": API_KEY,
            "action": "get_lines"
        }
    )
    
    data = response.json()
    if data["status"] == "STATUS_SUCCESS":
        return data["data"]
    else:
        raise Exception(f"API Error: {data.get('error', 'Unknown error')}")

# Usage
try:
    lines = get_lines()
    print(f"Found {len(lines)} subscription lines")
    
    for line in lines:
        print(f"- {line['username']} (ID: {line['id']})")
        
except Exception as e:
    print(f"Error: {e}")
```

### PHP

```php
<?php
// Configuration
$baseUrl = "http://your-server.com/cSbuFLhp/";
$apiKey = "8D3135D30437F86EAE2FA4A2A8345000";

function getLines($baseUrl, $apiKey) {
    $url = $baseUrl . "?api_key=" . $apiKey . "&action=get_lines";
    $response = file_get_contents($url);
    $data = json_decode($response, true);
    
    if ($data['status'] === 'STATUS_SUCCESS') {
        return $data['data'];
    } else {
        throw new Exception("API Error: " . ($data['error'] ?? 'Unknown error'));
    }
}

// Usage
try {
    $lines = getLines($baseUrl, $apiKey);
    echo "Found " . count($lines) . " subscription lines\n";
    
    foreach ($lines as $line) {
        echo "- {$line['username']} (ID: {$line['id']})\n";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
```

### JavaScript (Node.js)

```javascript
const fetch = require('node-fetch');

// Configuration
const BASE_URL = 'http://your-server.com/cSbuFLhp/';
const API_KEY = '8D3135D30437F86EAE2FA4A2A8345000';

async function getLines() {
    const url = `${BASE_URL}?api_key=${API_KEY}&action=get_lines`;
    
    const response = await fetch(url);
    const data = await response.json();
    
    if (data.status === 'STATUS_SUCCESS') {
        return data.data;
    } else {
        throw new Error(`API Error: ${data.error || 'Unknown error'}`);
    }
}

// Usage
(async () => {
    try {
        const lines = await getLines();
        console.log(`Found ${lines.length} subscription lines`);
        
        lines.forEach(line => {
            console.log(`- ${line.username} (ID: ${line.id})`);
        });
        
    } catch (error) {
        console.error('Error:', error.message);
    }
})();
```

### JavaScript (Browser/React)

```javascript
// React Hook Example
import { useState, useEffect } from 'react';

const API_CONFIG = {
    baseUrl: 'http://your-server.com/cSbuFLhp/',
    apiKey: '8D3135D30437F86EAE2FA4A2A8345000'
};

function useLines() {
    const [lines, setLines] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    
    useEffect(() => {
        async function fetchLines() {
            try {
                const url = `${API_CONFIG.baseUrl}?api_key=${API_CONFIG.apiKey}&action=get_lines`;
                const response = await fetch(url);
                const data = await response.json();
                
                if (data.status === 'STATUS_SUCCESS') {
                    setLines(data.data);
                } else {
                    setError(data.error || 'Unknown error');
                }
            } catch (err) {
                setError(err.message);
            } finally {
                setLoading(false);
            }
        }
        
        fetchLines();
    }, []);
    
    return { lines, loading, error };
}

// Component usage
function LinesList() {
    const { lines, loading, error } = useLines();
    
    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error}</div>;
    
    return (
        <div>
            <h2>Subscription Lines ({lines.length})</h2>
            <ul>
                {lines.map(line => (
                    <li key={line.id}>
                        {line.username} - Expires: {new Date(line.exp_date * 1000).toLocaleDateString()}
                    </li>
                ))}
            </ul>
        </div>
    );
}
```

---

## 🔍 Response Structure

### Success Response

```json
{
  "status": "STATUS_SUCCESS",
  "data": [
    // Array of objects
  ]
}
```

### Error Response

```json
{
  "status": "STATUS_FAILURE",
  "error": "Error message"
}
```

---

## 💡 Best Practices

### 1. Handle Large Datasets

For endpoints that may return large amounts of data:

```python
# Process data in chunks
def process_lines_in_batches(lines, batch_size=100):
    for i in range(0, len(lines), batch_size):
        batch = lines[i:i + batch_size]
        # Process batch
        yield batch
```

### 2. Cache Results

Cache frequently accessed data to reduce API calls:

```python
from functools import lru_cache
from datetime import datetime, timedelta

@lru_cache(maxsize=128)
def get_cached_lines(cache_key):
    return get_lines()

# Use with time-based cache key
cache_key = datetime.now().replace(minute=0, second=0, microsecond=0)
lines = get_cached_lines(cache_key)
```

### 3. Error Handling

Always handle errors gracefully:

```python
def safe_api_call(action):
    try:
        response = requests.get(
            BASE_URL,
            params={"api_key": API_KEY, "action": action},
            timeout=10
        )
        response.raise_for_status()
        data = response.json()
        
        if data["status"] != "STATUS_SUCCESS":
            logger.error(f"API returned error: {data.get('error')}")
            return None
            
        return data["data"]
        
    except requests.exceptions.Timeout:
        logger.error("API request timed out")
        return None
    except requests.exceptions.RequestException as e:
        logger.error(f"API request failed: {e}")
        return None
    except ValueError as e:
        logger.error(f"Invalid JSON response: {e}")
        return None
```

### 4. Rate Limiting

Implement rate limiting to avoid overloading the server:

```python
import time
from functools import wraps

def rate_limit(calls_per_minute=60):
    min_interval = 60.0 / calls_per_minute
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

@rate_limit(calls_per_minute=30)
def api_call(action):
    return requests.get(BASE_URL, params={"api_key": API_KEY, "action": action})
```

---

## 🎯 Common Use Cases

### Export All Data

```python
def export_all_data():
    """Export all panel data to JSON files"""
    endpoints = [
        'get_lines',
        'get_users',
        'get_streams',
        'get_movies',
        'get_series_list'
    ]
    
    for endpoint in endpoints:
        try:
            data = api_call(endpoint)
            with open(f"{endpoint}.json", 'w') as f:
                json.dump(data, f, indent=2)
            print(f"✓ Exported {endpoint}")
        except Exception as e:
            print(f"✗ Failed to export {endpoint}: {e}")
```

### Generate Report

```python
def generate_subscription_report():
    """Generate subscription statistics report"""
    lines = get_lines()
    
    total = len(lines)
    active = sum(1 for line in lines if line['enabled'] == '1')
    trial = sum(1 for line in lines if line['is_trial'] == '1')
    
    print(f"Subscription Report")
    print(f"==================")
    print(f"Total Lines: {total}")
    print(f"Active: {active}")
    print(f"Trial: {trial}")
    print(f"Inactive: {total - active}")
```

### Monitor Expirations

```python
from datetime import datetime, timedelta

def check_expiring_soon(days=7):
    """Find lines expiring in the next N days"""
    lines = get_lines()
    threshold = datetime.now() + timedelta(days=days)
    
    expiring = []
    for line in lines:
        exp_date = datetime.fromtimestamp(int(line['exp_date']))
        if exp_date <= threshold:
            expiring.append({
                'username': line['username'],
                'expires': exp_date.strftime('%Y-%m-%d'),
                'days_left': (exp_date - datetime.now()).days
            })
    
    return expiring
```

---

## 📚 Related Documentation

- [Authentication Guide](../authentication.md)
- [Line API - Creating/Editing Lines](03-line-api.md)
- [Error Handling](../error-codes.md)

---

## 🆘 Need Help?

- **GitHub Issues:** [Report problems](https://github.com/worldofiptvcom/xui-one-api-docs/issues)
- **Community:** [World of IPTV Forums](https://www.worldofiptv.com)
- **Documentation:** [Getting Started Guide](../getting-started.md)
