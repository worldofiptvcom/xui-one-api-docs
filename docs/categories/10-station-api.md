# Station API - Radio Station Management

Radio station configuration and management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_station` | POST | Create radio station |
| `edit_station` | POST | Edit station settings |
| `delete_station` | POST | Remove station |
| `enable_station` | POST | Activate station |
| `disable_station` | POST | Suspend station |
| `get_station` | GET | Get station details |

---

## Quick Example

```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_station" \
  -d "station_name=Radio 1" \
  -d "stream_source=http://radio.example.com/stream" \
  -d "category_id=1"
```

---

## 📚 Related: [GET INFO API - Query Stations](02-get-info.md#10-get-all-radio-stations)
