FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    chromium \
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV CHROME_BIN=/usr/bin/chromium

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:${PATH}"

RUN mkdir -p /home/node/.openclaw/workspace && \
    chown -R node:node /home/node/.openclaw && \
    mkdir -p /home/node/.npm-global && \
    chown -R node:node /home/node/.npm-global

USER node
WORKDIR /home/node

RUN npm install -g openclaw@latest

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["openclaw", "gateway"]
