# Channel API - Channel Management

Channel configuration and management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_channel` | POST | Create new channel |
| `edit_channel` | POST | Edit channel settings |
| `delete_channel` | POST | Remove channel |
| `enable_channel` | POST | Activate channel |
| `disable_channel` | POST | Suspend channel |
| `get_channel` | GET | Get channel details |

---

## Quick Example

```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_channel" \
  -d "channel_name=CNN HD" \
  -d "epg_id=cnn-hd" \
  -d "category_id=1"
```

---

## 📚 Related: [GET INFO API - Query Channels](02-get-info.md#4-get-all-channels)
