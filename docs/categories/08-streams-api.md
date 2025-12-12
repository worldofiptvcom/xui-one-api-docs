# Streams API - Live Stream Management

Complete documentation for live TV stream management in the XUI.ONE Admin API.

## 📋 Overview

Manage live TV streams including creation, editing, encoding control, and deletion.

### Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_stream` | POST | Create new live stream |
| `edit_stream` | POST | Edit stream settings |
| `delete_stream` | POST | Remove stream |
| `start_stream` | POST | Start stream encoding |
| `stop_stream` | POST | Stop stream encoding |
| `get_stream` | GET | Get stream details |

---

## Quick Examples

### Create Stream
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_stream" \
  -d "stream_display_name=CNN HD" \
  -d "stream_source=http://source.example.com/stream.m3u8" \
  -d "category_id=1" \
  -d "stream_icon=http://example.com/icon.png"
```

### Start/Stop Stream
```bash
# Start
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=start_stream" \
  -d "id=456"

# Stop
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=stop_stream" \
  -d "id=456"
```

---

## Python Example

```python
class XUIStreamsManager:
    def create_stream(self, name, source, category_id=1, icon=None):
        data = {
            'stream_display_name': name,
            'stream_source': source,
            'category_id': category_id
        }
        if icon:
            data['stream_icon'] = icon
        
        response = requests.post(
            self.base_url,
            params={'api_key': self.api_key, 'action': 'create_stream'},
            data=data
        )
        return response.json()
    
    def start_stream(self, stream_id):
        response = requests.post(
            self.base_url,
            params={'api_key': self.api_key, 'action': 'start_stream'},
            data={'id': stream_id}
        )
        return response.json()
```

---

## Supported Source Formats

- HLS (m3u8)
- RTMP
- HTTP/HTTPS
- UDP/MPEG-TS
- RTSP

---

## 📚 Related Documentation

- [GET INFO API - Query Streams](02-get-info.md#3-get-all-live-streams)
- [Stream Errors](04-logs-events.md#-stream-errors)
- [Watch Output](04-logs-events.md#-watch-stream-output)
