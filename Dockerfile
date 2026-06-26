FROM debian:bookworm-slim AS ffmpeg-getter
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget xz-utils ca-certificates \
    && rm -rf /var/lib/apt/lists/*
RUN wget -q https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    && tar xf ffmpeg-release-amd64-static.tar.xz \
    && mv ffmpeg-*/ffmpeg /tmp/ffmpeg \
    && mv ffmpeg-*/ffprobe /tmp/ffprobe

FROM n8nio/n8n:2.25.7
USER root
COPY --from=ffmpeg-getter /tmp/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg-getter /tmp/ffprobe /usr/local/bin/ffprobe
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
RUN mkdir -p /files && chown 1000:1000 /files && chmod 777 /files
USER node
