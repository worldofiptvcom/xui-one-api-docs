# Episode API - TV Episode Management

TV series episode management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_episode` | POST | Create episode |
| `edit_episode` | POST | Edit episode settings |
| `delete_episode` | POST | Remove episode |
| `enable_episode` | POST | Activate episode |
| `disable_episode` | POST | Suspend episode |
| `get_episode` | GET | Get episode details |

---

## Quick Example

```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_episode" \
  -d "series_id=101" \
  -d "season_num=1" \
  -d "episode_num=1" \
  -d "title=Pilot" \
  -d "stream_source=http://cdn.example.com/s01e01.mp4" \
  -d "plot=The beginning..." \
  -d "duration=45"
```

---

## Episode Fields

- `series_id` - Parent series ID (required)
- `season_num` - Season number
- `episode_num` - Episode number
- `title` - Episode title
- `stream_source` - Video file URL
- `plot` - Episode description
- `duration` - Duration in minutes
- `air_date` - Original air date

---

## Python Example

```python
def add_season(manager, series_id, season_num, episodes):
    """Add complete season to series"""
    results = []
    
    for ep_num, ep_data in enumerate(episodes, 1):
        result = manager.create_episode(
            series_id=series_id,
            season_num=season_num,
            episode_num=ep_num,
            title=ep_data['title'],
            stream_source=ep_data['source'],
            plot=ep_data.get('plot', ''),
            duration=ep_data.get('duration', 45)
        )
        results.append(result)
    
    return results
```

---

## 📚 Related: 
- [GET INFO API - Query Episodes](02-get-info.md#7-get-all-episodes)
- [Series API](12-series-api.md)
