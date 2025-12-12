# Movie API - VOD Movie Management

VOD movie management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `create_movie` | POST | Create VOD movie |
| `edit_movie` | POST | Edit movie settings |
| `delete_movie` | POST | Remove movie |
| `enable_movie` | POST | Activate movie |
| `disable_movie` | POST | Suspend movie |
| `get_movie` | GET | Get movie details |

---

## Quick Example

```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=create_movie" \
  -d "name=The Matrix" \
  -d "stream_source=http://cdn.example.com/matrix.mp4" \
  -d "category_id=5" \
  -d "plot=A computer hacker learns..." \
  -d "year=1999" \
  -d "cover=http://example.com/poster.jpg"
```

---

## Movie Metadata Fields

- `name` - Movie title
- `stream_source` - Video file URL
- `category_id` - Category assignment
- `plot` - Description
- `year` - Release year
- `cover` - Poster image URL
- `genre` - Movie genre
- `cast` - Cast members
- `director` - Director name
- `rating` - IMDB/TMDB rating

---

## 📚 Related: [GET INFO API - Query Movies](02-get-info.md#5-get-all-movies)
