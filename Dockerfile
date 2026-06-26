FROM n8nio/n8n:2.25.7

USER root
RUN apk add --no-cache ffmpeg
USER node
