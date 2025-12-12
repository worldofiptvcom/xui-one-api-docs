# Server API - Server & Load Balancer Management

Server infrastructure management endpoints.

## 📋 Available Operations

| Action | Method | Description |
|--------|--------|-------------|
| `install_server` | POST | Install new server |
| `edit_server` | POST | Edit server settings |
| `delete_server` | POST | Remove server |
| `restart_server` | POST | Restart server services |
| `get_server_info` | GET | Get server information |
| `get_server_stats` | GET | Get server statistics |
| `install_load_balancer` | POST | Install load balancer |
| `edit_load_balancer` | POST | Edit load balancer settings |

---

## Quick Examples

### Get Server Stats
```bash
curl "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=get_server_stats"
```

Response:
```json
{
  "status": "STATUS_SUCCESS",
  "data": {
    "cpu_usage": "45%",
    "memory_usage": "60%",
    "disk_usage": "75%",
    "network_in": "150 Mbps",
    "network_out": "200 Mbps",
    "active_connections": 1500
  }
}
```

### Restart Server
```bash
curl -X POST "http://your-server.com/cSbuFLhp/?api_key=API_KEY&action=restart_server" \
  -d "server_id=1"
```

---

## Python Monitoring Example

```python
def monitor_servers(manager):
    """Monitor all servers"""
    stats = manager.get_server_stats()
    
    alerts = []
    if float(stats['cpu_usage'].rstrip('%')) > 80:
        alerts.append("High CPU usage")
    if float(stats['memory_usage'].rstrip('%')) > 80:
        alerts.append("High memory usage")
    if float(stats['disk_usage'].rstrip('%')) > 85:
        alerts.append("Low disk space")
    
    if alerts:
        print("⚠️ Alerts:", ", ".join(alerts))
    else:
        print("✓ All servers healthy")
```

---

## 📚 Related: [Logs & Events](04-logs-events.md)
