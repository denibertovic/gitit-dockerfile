#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback
USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user

git config --global user.email ${USER_EMAIL:-user@localhost}
git config --global user.name  ${USER_NAMEL:-user}

exec /usr/local/sbin/pid1 -u user -g user "$@"
