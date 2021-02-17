FROM alpine

LABEL org.opencontainers.image.source="https://github.com/0xERR0R/navidrome-backup-docker" \
      org.opencontainers.image.url="https://github.com/0xERR0R/navidrome-backup-docker" \
      org.opencontainers.image.title="Simple backup for Navidrome"

RUN apk add --update \
    sqlite \
    bash \
    p7zip

ADD backup.sh /opt/backup/
ADD reports /opt/reports/

VOLUME /out

WORKDIR /opt/backup/

ENTRYPOINT /opt/backup/backup.sh