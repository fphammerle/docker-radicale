FROM alpine:3.10

# storage hooks
RUN apk add --no-cache git

# py3-passlib & py3-bcrypt required for htpasswd_encryption=bcrypt
# https://github.com/pyca/bcrypt/
# > from bcrypt import _bcrypt
# > ModuleNotFoundError: No module named '_cffi_backend'
RUN apk add --no-cache py3-bcrypt py3-cffi

ARG REPOSITORY=http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add --repository=$REPOSITORY --no-cache radicale py3-passlib

ENV COLLECTIONS_PATH=/var/lib/radicale/collections
RUN mkdir "$COLLECTIONS_PATH" && chown radicale "$COLLECTIONS_PATH"
VOLUME $COLLECTIONS_PATH

ENV CONFIG_PATH=/etc/radicale/config

USER radicale
EXPOSE 5232/tcp
CMD radicale --server-hosts=0.0.0.0:5232 \
    --config="$CONFIG_PATH" \
    --storage-filesystem-folder="$COLLECTIONS_PATH" \
    --debug --logging-mask-passwords
