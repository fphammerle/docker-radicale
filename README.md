# Radicale ☎️ 📅 📱 ☁️ 🐳

CalDAV (calendars, todo-lists) and CardDAV (contacts) server

https://radicale.org/

## Setup

1. Create config ( https://radicale.org/configuration/ )

   Example:
   ```
   [auth]
   type = htpasswd
   htpasswd_filename = /etc/radicale/htpasswd
   htpasswd_encryption = bcrypt

   [rights]
   type = authenticated
   ```

2. Store credentials
   ```sh
   htpasswd -cB htpasswd alice
   htpasswd -B htpasswd bob
   ```

3. Test config
   ```sh
   docker run --rm \
       -v $PWD/config:/etc/radicale/config \
       -v $PWD/htpasswd:/etc/radicale/htpasswd \
       -p 5232:5232 fphammerle/radicale
   ```

4. Start daemon
   ```sh
   docker run --name radicale \
       -v $PWD/config:/etc/radicale/config:ro \
       -v $PWD/htpasswd:/etc/radicale/htpasswd:ro \
       -v radicale-collections:/var/lib/radicale/collections:rw \
       --detach --restart unless-stopped \
       -p 5232:5232 \
       fphammerle/radicale
   ```

## Docker Compose 🐙

1. `git clone https://github.com/fphammerle/docker-radicale`
2. `cd docker-radicale`
3. Adapt mount points in [docker-compose.yml](docker-compose.yml)
4. `docker-compose up`
