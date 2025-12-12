# Series API - TV Series Management

TV series management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_series` | POST | Create TV series |
| `edit_series` | POST | Edit series settings |
| `delete_series` | POST | Remove series |
| `get_series` | GET | Get series details |

---

## Quick Example

```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_series" \
  -d "name=Breaking Bad" \
  -d "category_id=3" \
  -d "cover=http://example.com/cover.jpg" \
  -d "plot=A high school chemistry teacher..." \
  -d "year=2008"
```

---

## Series Metadata

- `name` - Series title
- `category_id` - Category assignment
- `cover` - Cover image URL
- `plot` - Description
- `year` - First aired year
- `cast` - Cast members
- `director` - Director/Creator
- `genre` - Series genre
- `rating` - Rating

---

## 📚 Related: 
- [GET INFO API - Query Series](02-get-info.md#6-get-all-series)
- [Episode API](13-episode-api.md)
