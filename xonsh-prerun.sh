CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -d "$CURR_DIR/bin/xonsh-files" ] && [ -x "$CURR_DIR/bin/xonsh-appimage" ]; then
  cd bin
  # This is noisy, so we want to suppress the output
  ./xonsh-appimage --appimage-extract > /dev/null
  mv squashfs-root xonsh-files
  ln -s xonsh-files/usr/bin/xonsh xonsh
  ln -s xonsh-files/usr/bin/python xonsh-python
  ln -s xonsh-files/usr/bin/pip xonsh-pip
fi

