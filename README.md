# TideProxy

**One repo. One server. Frontend + proxy together.**

Tide is a clean web proxy — the beautiful dark-teal frontend and the Python asyncio backend live in the same repository and run on the same port.

```
visit  https://your-server.com/        → Tide UI
browse https://your-server.com/proxy?url=https://youtube.com → proxied
check  https://your-server.com/health  → liveness probe
```

---

## Structure

```
tideproxy/
├── static/
│   └── index.html        ← Tide frontend (the UI you see)
├── src/
│   ├── main.py           ← unified server (frontend + proxy on :8080)
│   ├── config.py         ← env-var config
│   ├── proxy/            ← HTTP/HTTPS CONNECT/SOCKS5 proxy
│   ├── auth/             ← Basic Auth + IP whitelist
│   ├── security/         ← SSRF protection
│   ├── health/           ← /health + /metrics endpoints
│   └── logging_utils/    ← structured JSON logger
├── tests/                ← 61 unit tests
├── Dockerfile
├── docker-compose.yml
├── pyproject.toml
└── .env.example
```

---

## Deploy on Railway (recommended — free tier)

1. Push this repo to GitHub
2. Go to **railway.app** → New Project → Deploy from GitHub
3. Select this repo — Railway detects the `Dockerfile` automatically
4. Click **Deploy**
5. Railway gives you a URL like `https://tideproxy-production.up.railway.app`

That's it. The frontend and proxy are both live on the same URL.

---

## Deploy with Docker

```bash
git clone https://github.com/YOUR_USERNAME/tideproxy.git
cd tideproxy
cp .env.example .env
docker compose up -d

# Visit: http://localhost:8080
```

---

## Run locally (no Docker)

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e ".[tls]"
python -m src.main

# Visit: http://localhost:8080
```

---

## Configuration

All settings via environment variables — see `.env.example` for the full list.

| Variable | Default | Description |
|---|---|---|
| `PROXY_HTTP_ADDR` | `:8080` | Frontend + proxy listen address |
| `PROXY_HEALTH_ADDR` | `:9090` | Health/metrics endpoint |
| `PROXY_AUTH_MODE` | `none` | `none` · `basic` · `ip` · `both` |
| `PROXY_AUTH_USERS` | — | `user:pass,user2:pass2` |
| `PROXY_IP_WHITELIST` | — | `10.0.0.0/8,1.2.3.4` |
| `PROXY_BLOCK_PRIVATE` | `true` | Block RFC 1918 ranges (SSRF) |
| `PROXY_LOG_LEVEL` | `INFO` | `DEBUG` · `INFO` · `WARNING` · `ERROR` |

---

## License

MIT
