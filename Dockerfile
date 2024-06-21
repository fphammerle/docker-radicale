FROM docker.io/alpine:3.20.1

# git & openssh-client for storage hooks
# py3-passlib & py3-bcrypt required for htpasswd_encryption=bcrypt
# https://github.com/pyca/bcrypt/
# > from bcrypt import _bcrypt
# > ModuleNotFoundError: No module named '_cffi_backend'
# https://git.alpinelinux.org/aports/log/community/radicale?h=3.20-stable
ARG RADICALE_PACKAGE_VERSION=3.1.9-r1
RUN apk add --no-cache \
        git \
        openssh-client \
        py3-bcrypt \
        py3-cffi \
        py3-passlib \
        radicale=$RADICALE_PACKAGE_VERSION

COPY ssh_config /etc/ssh/ssh_config

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
