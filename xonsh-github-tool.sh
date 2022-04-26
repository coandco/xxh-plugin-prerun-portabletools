#!/usr/bin/env bash

tool_github_repo="xonsh/xonsh"
tool_arch="x86_64"
tool_version="latest"

install_tool() {
  local downloaded_file="$1"
  local output_dir="$2"
  if [ -f "$downloaded_file" ]; then
    chmod a+x "$downloaded_file"
    mv "$downloaded_file" "$output_dir/xonsh-appimage"
  else
    echo "Couldn't find downloaded xonsh appimage at $downloaded_file!"
    exit 1
  fi
}
