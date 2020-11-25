#!/bin/sh

set -ex

# for storage hooks
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub
fi

exec radicale \
    --server-hosts=0.0.0.0:5232 \
    --config="$CONFIG_PATH" \
    --storage-filesystem-folder="$COLLECTIONS_PATH" \
    --logging-mask-passwords
