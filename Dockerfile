# ── Stage 1: builder ──────────────────────────────────────────────────────────
FROM python:3.12-slim AS builder

WORKDIR /build

RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml ./
RUN pip install --upgrade pip \
 && pip install --no-cache-dir --prefix=/install .

# ── Stage 2: runtime ──────────────────────────────────────────────────────────
FROM python:3.12-slim

WORKDIR /app

# Create non-root user
RUN useradd --no-create-home --shell /bin/false --uid 1001 proxy

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Copy source code and frontend
COPY src/ ./src/
COPY static/ ./static/

# Fix ownership
RUN chown -R proxy:proxy /app

USER proxy

EXPOSE 8080 9090

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:9090/health')" || exit 1

ENTRYPOINT ["python", "-m", "src.main"]
