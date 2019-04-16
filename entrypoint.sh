#! /bin/bash -e

if id gollumuser &> /dev/null; then
  echo "Removing existing user"
  userdel gollumuser
fi

if ! grep $PGID /etc/group &> /dev/null; then
  if grep gollumuser /etc/group &> /dev/null; then
    echo "Deleting existing gollumuser group"
    groupdel gollumuser
  fi
  echo "Creating gollumuser group"
  groupadd -g $PGID gollumuser
fi

echo "Creating gollumuser"
useradd -l -u $PUID -g $PGID gollumuser
chown gollumuser:$PGID $TARGET_DIR

if [[ $# -eq 1 ]]; then
  case "$1" in
    "console" )
      exec /bin/bash
      ;;
    "root" )
      exec sudo -E -u gollumuser -H /bin/bash
      ;;
  esac
fi

if ! /usr/bin/git status $TARGET_DIR &> /dev/null; then
  echo "Initialising git repository in $TARGET_DIR"
  sudo -E -u gollumuser -H /usr/bin/git init $TARGET_DIR
fi

echo "Starting gollum"
exec sudo -E -u gollumuser -H /usr/src/app/wrapper.rb $GOLLUM_OPTIONS $TARGET_DIR
