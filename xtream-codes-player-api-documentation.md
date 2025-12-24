# Xtream Codes API Documentation

Complete API reference for the Xtream Codes Player API.

---

## Table of Contents

- [Overview](#overview)
- [Authentication](#authentication)
- [Base URL](#base-url)
- [User Info](#user-info)
- [Live Channels](#live-channels)
  - [Get Live Categories](#get-live-categories)
  - [Get Live Streams](#get-live-streams)
- [VOD (Movies)](#vod-movies)
  - [Get VOD Categories](#get-vod-categories)
  - [Get VOD Streams](#get-vod-streams)
  - [Get VOD Info](#get-vod-info)
- [Series](#series)
- [EPG (Electronic Program Guide)](#epg-electronic-program-guide)
  - [Get Short EPG](#get-short-epg)
  - [Get Full EPG](#get-full-epg)
- [Response Codes](#response-codes)
- [Data Models](#data-models)

---

## Overview

The Xtream Codes Player API provides access to IPTV content including live streams, video on demand (VOD), and electronic program guide (EPG) data.

### Available Actions

| Action | Description | Category |
|--------|-------------|----------|
| *(none)* | Get user account & server info | User Info |
| `get_live_categories` | List all live stream categories | Live |
| `get_live_streams` | List all live channels | Live |
| `get_vod_categories` | List all VOD/movie categories | VOD |
| `get_vod_streams` | List all movies | VOD |
| `get_vod_info` | Get detailed movie information | VOD |
| `get_short_epg` | Get short EPG for a channel | EPG |
| `get_simple_data_table` | Get full EPG listing | EPG |

---

## Authentication

All API requests require authentication via `username` and `password` query parameters.

```
?username=YOUR_USERNAME&password=YOUR_PASSWORD
```

### Authentication Failure Response

```json
{
  "user_info": {
    "auth": 0
  }
}
```

---

## Base URL

```
http://SERVER_ADDRESS:PORT/player_api.php
```

Replace `SERVER_ADDRESS` and `PORT` with your server details.

---

## User Info

Get account information and server details.

### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |

> **Note:** Do not include an `action` parameter to get user info.

### Example Request

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123"
```

### Example Response

```json
{
  "user_info": {
    "username": "john",
    "password": "secret123",
    "auth": 1,
    "message": "",
    "status": "Active",
    "exp_date": 1735689600,
    "is_trial": 0,
    "active_cons": 1,
    "created_at": 1704067200,
    "max_connections": 2,
    "allowed_output_formats": ["m3u8", "ts"]
  },
  "server_info": {
    "url": "example.com",
    "port": "8080",
    "server_protocol": "http",
    "timezone": "UTC",
    "timestamp_now": 1703980800,
    "time_now": "2024-12-31 12:00:00",
    "rtmp_port": "",
    "https_port": ""
  }
}
```

### User Status Values

| Status | Description |
|--------|-------------|
| `Active` | Account is enabled and not expired |
| `Banned` | Account banned by administrator |
| `Disabled` | Account is disabled |
| `Expired` | Account has passed expiration date |

### Response Fields

#### `user_info` Object

| Field | Type | Description |
|-------|------|-------------|
| `username` | string | Account username |
| `password` | string | Account password |
| `auth` | integer | Authentication status (1 = success, 0 = failed) |
| `message` | string | System message (if any) |
| `status` | string | Account status |
| `exp_date` | integer/null | Expiration timestamp (null = never expires) |
| `is_trial` | integer | Trial account flag (1 = trial, 0 = regular) |
| `active_cons` | integer | Current active connections |
| `created_at` | integer | Account creation timestamp |
| `max_connections` | integer | Maximum allowed simultaneous connections |
| `allowed_output_formats` | array | Allowed streaming formats |

#### `server_info` Object

| Field | Type | Description |
|-------|------|-------------|
| `url` | string | Server URL or IP address |
| `port` | string | Server port |
| `server_protocol` | string | Protocol (http/https) |
| `timezone` | string | Server timezone |
| `timestamp_now` | integer | Current server timestamp |
| `time_now` | string | Current server time (Y-m-d H:i:s) |
| `rtmp_port` | string | RTMP port (if available) |
| `https_port` | string | HTTPS port (if available) |

---

## Live Channels

### Get Live Categories

Retrieve all available live stream categories.

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_live_categories` |

#### Example Request

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_live_categories"
```

#### Example Response

```json
[
  {
    "category_id": "1",
    "category_name": "Sports",
    "parent_id": 0
  },
  {
    "category_id": "2",
    "category_name": "News",
    "parent_id": 0
  },
  {
    "category_id": "3",
    "category_name": "Entertainment",
    "parent_id": 0
  }
]
```

#### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `category_id` | string | Unique category identifier |
| `category_name` | string | Category display name |
| `parent_id` | integer | Parent category ID (0 = root) |

---

### Get Live Streams

Retrieve all available live channels, optionally filtered by category.

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_live_streams` |
| `category_id` | string | ❌ No | Filter by category ID |

#### Example Request - All Streams

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_live_streams"
```

#### Example Request - Filter by Category

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_live_streams&category_id=1"
```

#### Example Response

```json
[
  {
    "num": 1,
    "name": "Sports Channel HD",
    "stream_type": "live",
    "stream_id": 101,
    "stream_icon": "http://example.com/icons/sports.png",
    "epg_channel_id": "sports.us",
    "added": "1704067200",
    "category_id": "1",
    "tv_archive": 0,
    "direct_source": "",
    "tv_archive_duration": 0
  },
  {
    "num": 2,
    "name": "News 24/7",
    "stream_type": "live",
    "stream_id": 102,
    "stream_icon": "http://example.com/icons/news.png",
    "epg_channel_id": "news.us",
    "added": "1704067200",
    "category_id": "2",
    "tv_archive": 0,
    "direct_source": "",
    "tv_archive_duration": 0
  }
]
```

#### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `num` | integer | Stream number in list |
| `name` | string | Channel display name |
| `stream_type` | string | Always `live` for live streams |
| `stream_id` | integer | Unique stream identifier |
| `stream_icon` | string | Channel logo URL |
| `epg_channel_id` | string | EPG channel identifier |
| `added` | string | Timestamp when stream was added |
| `category_id` | string | Category the stream belongs to |
| `tv_archive` | integer | TV archive availability (0/1) |
| `direct_source` | string | Direct source URL (if available) |
| `tv_archive_duration` | integer | Archive duration in days |

#### Playing a Live Stream

To play a live stream, use this URL format:

```
http://SERVER:PORT/USERNAME/PASSWORD/STREAM_ID.EXT
```

**Example:**
```
http://example.com:8080/john/secret123/101.m3u8
http://example.com:8080/john/secret123/101.ts
```

---

## VOD (Movies)

### Get VOD Categories

Retrieve all available movie categories.

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_vod_categories` |

#### Example Request

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_vod_categories"
```

#### Example Response

```json
[
  {
    "category_id": "10",
    "category_name": "Action",
    "parent_id": 0
  },
  {
    "category_id": "11",
    "category_name": "Comedy",
    "parent_id": 0
  },
  {
    "category_id": "12",
    "category_name": "Drama",
    "parent_id": 0
  }
]
```

---

### Get VOD Streams

Retrieve all available movies, optionally filtered by category.

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_vod_streams` |
| `category_id` | string | ❌ No | Filter by category ID |

#### Example Request - All Movies

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_vod_streams"
```

#### Example Request - Filter by Category

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_vod_streams&category_id=10"
```

#### Example Response

```json
[
  {
    "num": 1,
    "name": "Action Movie 2024",
    "stream_type": "movie",
    "stream_id": 5001,
    "stream_icon": "http://example.com/posters/movie1.jpg",
    "added": "1704067200",
    "category_id": "10",
    "direct_source": "",
    "rating": 7.5,
    "rating_5based": 4,
    "custom_sid": null,
    "container_extension": "mkv"
  },
  {
    "num": 2,
    "name": "Comedy Film",
    "stream_type": "movie",
    "stream_id": 5002,
    "stream_icon": "http://example.com/posters/movie2.jpg",
    "added": "1704153600",
    "category_id": "11",
    "direct_source": "",
    "rating": 6.8,
    "rating_5based": 3,
    "custom_sid": null,
    "container_extension": "mp4"
  }
]
```

#### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `num` | integer | Movie number in list |
| `name` | string | Movie title |
| `stream_type` | string | Always `movie` for VOD |
| `stream_id` | integer | Unique movie identifier |
| `stream_icon` | string | Movie poster URL |
| `added` | string | Timestamp when movie was added |
| `category_id` | string | Category the movie belongs to |
| `direct_source` | string | Direct source URL (if available) |
| `rating` | float/null | Rating out of 10 |
| `rating_5based` | integer | Rating out of 5 (rounded up) |
| `custom_sid` | null | Custom stream ID |
| `container_extension` | string | File extension (mp4, mkv, avi, etc.) |

---

### Get VOD Info

Retrieve detailed information about a specific movie.

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_vod_info` |
| `vod_id` | integer | ✅ Yes | Movie/VOD stream ID |

#### Example Request

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_vod_info&vod_id=5001"
```

#### Example Response

```json
{
  "info": {
    "imdb_id": "",
    "movie_image": "http://example.com/posters/movie1.jpg",
    "genre": "Action, Thriller",
    "plot": "An exciting action movie about a hero saving the world.",
    "cast": "Actor One, Actor Two, Actor Three",
    "director": "Famous Director",
    "rating": 7.5,
    "releasedate": "2024-01-15",
    "duration_secs": 7200,
    "duration": "02:00:00",
    "bitrate": 4500,
    "kinopoisk_url": "",
    "episode_run_time": "",
    "youtube_trailer": "",
    "actors": "Actor One, Actor Two, Actor Three",
    "name": "Action Movie 2024",
    "name_o": "Action Movie 2024",
    "cover_big": "http://example.com/posters/movie1.jpg",
    "description": "An exciting action movie about a hero saving the world.",
    "age": "",
    "rating_mpaa": "",
    "rating_count_kinopoisk": 0,
    "country": "",
    "backdrop_path": [],
    "audio": [],
    "video": []
  },
  "movie_data": {
    "stream_id": 5001,
    "name": "Action Movie 2024",
    "added": "1704067200",
    "category_id": "10",
    "container_extension": "mkv",
    "custom_sid": "",
    "direct_source": ""
  }
}
```

#### Response Fields

##### `info` Object

| Field | Type | Description |
|-------|------|-------------|
| `imdb_id` | string | IMDB identifier |
| `movie_image` | string | Movie poster URL |
| `genre` | string | Movie genres |
| `plot` | string | Movie plot/synopsis |
| `cast` | string | Cast members |
| `director` | string | Director name |
| `rating` | float/null | Rating out of 10 |
| `releasedate` | string | Release date |
| `duration_secs` | integer | Duration in seconds |
| `duration` | string | Duration formatted (HH:MM:SS) |
| `bitrate` | integer | Video bitrate |
| `youtube_trailer` | string | YouTube trailer URL |
| `name` | string | Movie title |
| `description` | string | Movie description |
| `backdrop_path` | array | Backdrop images |
| `audio` | array | Audio track information |
| `video` | array | Video track information |

##### `movie_data` Object

| Field | Type | Description |
|-------|------|-------------|
| `stream_id` | integer | Stream identifier |
| `name` | string | Movie title |
| `added` | string | Timestamp when added |
| `category_id` | string | Category ID |
| `container_extension` | string | File extension |
| `custom_sid` | string | Custom stream ID |
| `direct_source` | string | Direct source URL |

#### Playing a VOD Stream

To play a movie, use this URL format:

```
http://SERVER:PORT/movie/USERNAME/PASSWORD/STREAM_ID.EXTENSION
```

**Example:**
```
http://example.com:8080/movie/john/secret123/5001.mkv
```

---

## Series

> ⚠️ **Note:** Series endpoints are not available in this API version. The available actions are limited to:
> - `get_live_categories`
> - `get_vod_categories`
> - `get_live_streams`
> - `get_vod_streams`
> - `get_vod_info`
> - `get_short_epg`
> - `get_simple_data_table`

Series functionality may be available in other API endpoints or a different version.

---

## EPG (Electronic Program Guide)

### Get Short EPG

Retrieve a short EPG listing for a specific channel.

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_short_epg` |
| `stream_id` | integer | ✅ Yes | Live stream ID |
| `limit` | integer | ❌ No | Number of EPG entries (default: 4) |

#### Example Request - Default Limit

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_short_epg&stream_id=101"
```

#### Example Request - Custom Limit

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_short_epg&stream_id=101&limit=10"
```

#### Example Response

```json
{
  "epg_listings": [
    {
      "id": "12345",
      "epg_id": "67890",
      "title": "TW9ybmluZyBOZXdz",
      "description": "RGFpbHkgbmV3cyBicm9hZGNhc3Q=",
      "start": "2024-12-31 08:00:00",
      "end": "2024-12-31 09:00:00",
      "start_timestamp": 1704009600,
      "stop_timestamp": 1704013200
    },
    {
      "id": "12346",
      "epg_id": "67890",
      "title": "U3BvcnRzIFVwZGF0ZQ==",
      "description": "TGF0ZXN0IHNwb3J0cyBoaWdobGlnaHRz",
      "start": "2024-12-31 09:00:00",
      "end": "2024-12-31 10:00:00",
      "start_timestamp": 1704013200,
      "stop_timestamp": 1704016800
    }
  ]
}
```

#### Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | EPG entry ID |
| `epg_id` | string | EPG channel ID |
| `title` | string | Program title (**Base64 encoded**) |
| `description` | string | Program description (**Base64 encoded**) |
| `start` | string | Start time (Y-m-d H:i:s) |
| `end` | string | End time (Y-m-d H:i:s) |
| `start_timestamp` | integer | Start time as Unix timestamp |
| `stop_timestamp` | integer | End time as Unix timestamp |

> **Important:** The `title` and `description` fields are **Base64 encoded**. Decode them to get the actual text.

#### Decoding Example (JavaScript)

```javascript
const title = atob("TW9ybmluZyBOZXdz"); // "Morning News"
const description = atob("RGFpbHkgbmV3cyBicm9hZGNhc3Q="); // "Daily news broadcast"
```

#### Decoding Example (Python)

```python
import base64
title = base64.b64decode("TW9ybmluZyBOZXdz").decode('utf-8')  # "Morning News"
```

#### Decoding Example (PHP)

```php
$title = base64_decode("TW9ybmluZyBOZXdz"); // "Morning News"
```

---

### Get Full EPG

Retrieve a complete EPG listing for a specific channel (up to 1000 entries).

#### Request

**Endpoint:** `GET /player_api.php`

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `username` | string | ✅ Yes | Account username |
| `password` | string | ✅ Yes | Account password |
| `action` | string | ✅ Yes | `get_simple_data_table` |
| `stream_id` | integer | ✅ Yes | Live stream ID |

#### Example Request

```bash
curl -X GET "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_simple_data_table&stream_id=101"
```

#### Example Response

```json
{
  "epg_listings": [
    {
      "id": "12345",
      "epg_id": "67890",
      "title": "TW9ybmluZyBOZXdz",
      "description": "RGFpbHkgbmV3cyBicm9hZGNhc3Q=",
      "start": "2024-12-31 08:00:00",
      "end": "2024-12-31 09:00:00",
      "start_timestamp": 1704009600,
      "stop_timestamp": 1704013200,
      "now_playing": 1,
      "has_archive": 0
    },
    {
      "id": "12346",
      "epg_id": "67890",
      "title": "U3BvcnRzIFVwZGF0ZQ==",
      "description": "TGF0ZXN0IHNwb3J0cyBoaWdobGlnaHRz",
      "start": "2024-12-31 09:00:00",
      "end": "2024-12-31 10:00:00",
      "start_timestamp": 1704013200,
      "stop_timestamp": 1704016800,
      "now_playing": 0,
      "has_archive": 0
    }
  ]
}
```

#### Additional Response Fields

| Field | Type | Description |
|-------|------|-------------|
| `now_playing` | integer | Currently playing indicator (1 = yes, 0 = no) |
| `has_archive` | integer | Archive availability (1 = yes, 0 = no) |

> **Note:** The first entry in the response has `now_playing: 1` to indicate it's the current program.

---

## Response Codes

### HTTP Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 400 | Bad Request |
| 401 | Unauthorized (invalid credentials) |
| 500 | Server Error |

### Authentication Response

| `auth` Value | Description |
|--------------|-------------|
| `1` | Authentication successful |
| `0` | Authentication failed |

---

## Data Models

### User Object

```json
{
  "username": "string",
  "password": "string",
  "auth": "integer",
  "message": "string",
  "status": "string (Active|Banned|Disabled|Expired)",
  "exp_date": "integer|null",
  "is_trial": "integer",
  "active_cons": "integer",
  "created_at": "integer",
  "max_connections": "integer",
  "allowed_output_formats": ["string"]
}
```

### Category Object

```json
{
  "category_id": "string",
  "category_name": "string",
  "parent_id": "integer"
}
```

### Live Stream Object

```json
{
  "num": "integer",
  "name": "string",
  "stream_type": "live",
  "stream_id": "integer",
  "stream_icon": "string",
  "epg_channel_id": "string",
  "added": "string",
  "category_id": "string",
  "tv_archive": "integer",
  "direct_source": "string",
  "tv_archive_duration": "integer"
}
```

### VOD Stream Object

```json
{
  "num": "integer",
  "name": "string",
  "stream_type": "movie",
  "stream_id": "integer",
  "stream_icon": "string",
  "added": "string",
  "category_id": "string",
  "direct_source": "string",
  "rating": "float|null",
  "rating_5based": "integer",
  "custom_sid": "null",
  "container_extension": "string"
}
```

### EPG Entry Object

```json
{
  "id": "string",
  "epg_id": "string",
  "title": "string (Base64)",
  "description": "string (Base64)",
  "start": "string (Y-m-d H:i:s)",
  "end": "string (Y-m-d H:i:s)",
  "start_timestamp": "integer",
  "stop_timestamp": "integer",
  "now_playing": "integer (only in get_simple_data_table)",
  "has_archive": "integer (only in get_simple_data_table)"
}
```

---

## Stream URL Formats

### Live Stream URL

```
http://SERVER:PORT/USERNAME/PASSWORD/STREAM_ID.EXTENSION
```

**Extensions:** `m3u8`, `ts`

**Example:**
```
http://example.com:8080/john/secret123/101.m3u8
```

### VOD/Movie URL

```
http://SERVER:PORT/movie/USERNAME/PASSWORD/STREAM_ID.EXTENSION
```

**Extensions:** `mp4`, `mkv`, `avi` (as specified in `container_extension`)

**Example:**
```
http://example.com:8080/movie/john/secret123/5001.mkv
```

### Series Episode URL

```
http://SERVER:PORT/series/USERNAME/PASSWORD/STREAM_ID.EXTENSION
```

---

## Quick Reference

### Complete API Endpoints Summary

| Endpoint | Method | Action | Required Params | Optional Params |
|----------|--------|--------|-----------------|-----------------|
| `/player_api.php` | GET | User Info | `username`, `password` | - |
| `/player_api.php` | GET | `get_live_categories` | `username`, `password` | - |
| `/player_api.php` | GET | `get_live_streams` | `username`, `password` | `category_id` |
| `/player_api.php` | GET | `get_vod_categories` | `username`, `password` | - |
| `/player_api.php` | GET | `get_vod_streams` | `username`, `password` | `category_id` |
| `/player_api.php` | GET | `get_vod_info` | `username`, `password`, `vod_id` | - |
| `/player_api.php` | GET | `get_short_epg` | `username`, `password`, `stream_id` | `limit` |
| `/player_api.php` | GET | `get_simple_data_table` | `username`, `password`, `stream_id` | - |

---

## Example Workflow

### 1. Authenticate and Get User Info

```bash
curl "http://example.com:8080/player_api.php?username=john&password=secret123"
```

### 2. Get Live Categories

```bash
curl "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_live_categories"
```

### 3. Get Streams in a Category

```bash
curl "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_live_streams&category_id=1"
```

### 4. Get EPG for a Stream

```bash
curl "http://example.com:8080/player_api.php?username=john&password=secret123&action=get_short_epg&stream_id=101"
```

### 5. Play the Stream

```
http://example.com:8080/john/secret123/101.m3u8
```

---

*Documentation generated based on Xtream Codes Player API source code.*
