FROM alpine:3.14.0

# git & openssh-client for storage hooks
# py3-passlib & py3-bcrypt required for htpasswd_encryption=bcrypt
# https://github.com/pyca/bcrypt/
# > from bcrypt import _bcrypt
# > ModuleNotFoundError: No module named '_cffi_backend'
ARG RADICALE_PACKAGE_VERSION=3.0.6-r2
RUN apk add --no-cache \
        git \
        openssh-client \
        py3-bcrypt \
        py3-cffi \
        py3-passlib \
        radicale=$RADICALE_PACKAGE_VERSION

ENV CONFIG_PATH=/etc/radicale/config
ENV COLLECTIONS_PATH=/var/lib/radicale/collections
COPY radicale.sh /
RUN mkdir "$COLLECTIONS_PATH" ~radicale/.ssh \
    && chown radicale "$COLLECTIONS_PATH" ~radicale/.ssh \
    && chmod a+rx /radicale.sh
VOLUME $COLLECTIONS_PATH

USER radicale
EXPOSE 5232/tcp
CMD ["/radicale.sh"]
