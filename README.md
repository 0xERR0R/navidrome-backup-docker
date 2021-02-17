# Backup for Navidrome

Creates a backup from navidrome's database and executes SQL reports.


Usage with navidrome and [crony](https://github.com/0xERR0R/crony):

docker-compose.yml

```yml
version: "2.1"
services:
  navidrome:
    image: deluan/navidrome
    container_name: navidrome
    environment:
      - TZ=Europe/Berlin
      - ND_SCANINTERVAL=10m
      - ND_SESSIONTIMEOUT=24h
    volumes:
      - music:/music/:ro
      - data:/data
    mem_limit: 300m
    ports:
      - 4533:4533
  backup:
    image: ghcr.io/0xerr0r/navidrome-backup-docker
    container_name: navidrome-backup
    depends_on: 
      - navidrome
    volumes:
      - backup:/out/
    volumes_from:
      - navidrome
    labels:
      # every monday
      - crony.schedule="0 0 * * 1"
volumes:
   music:
    driver: local
    driver_opts:
      type: cifs
      o: username=xxx,password=xxx,rw
      device: //192.168.178.xxx/path/to/music
   backup:
    driver: local
    driver_opts:
      type: cifs
      o: username=xxx,password=xxx,rw
      device: //192.168.178.xxx/path/to/backup
   data:
```