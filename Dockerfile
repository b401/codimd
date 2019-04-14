FROM node:carbon-jessie

VOLUME /var/hackadoc

RUN apt update && apt install -y \
  git \
  sqlite3

RUN git clone -b asciidoc https://github.com/b401/codimd.git /var/hackadoc
WORKDIR /var/hackadoc
RUN npm install \
  && npm run build \
  && npm prune --production

RUN apt remove -y --auto-remove \
  build-essential \
  && apt purge \
  && rm -r /var/lib/apt/lists/*

COPY config.json config.json
COPY sequelizerc .sequelizerc

CMD ["node", "app.js"]
