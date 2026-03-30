# ── Stage 1: builder ──────────────────────────────────────────────────────────
FROM python:3.12-slim AS builder
RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /build
COPY pyproject.toml ./
RUN pip install --upgrade pip && pip install --no-cache-dir --prefix=/install .

# ── Stage 2: runtime ──────────────────────────────────────────────────────────
FROM python:3.12-slim AS runtime
RUN useradd --no-create-home --shell /bin/false --uid 1001 proxy
WORKDIR /app
COPY --from=builder /install /usr/local
COPY --chown=proxy:proxy src/     ./src/
COPY --chown=proxy:proxy static/  ./static/
USER proxy

# HTTP proxy + frontend on 8080, health on 9090
EXPOSE 8080 9090

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:9090/health')" || exit 1

ENTRYPOINT ["python", "-m", "src.main"]
