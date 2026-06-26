FROM n8nio/n8n:2.25.7

USER root
RUN apt-get update && apt-get install -y ffmpeg --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*
USER node
