#!/usr/bin/env bash

tool_github_repo="junegunn/fzf"
tool_arch="linux_amd64"
tool_version="latest"

install_tool() {
  local downloaded_file="$1"
  local output_dir="$2"
  if [ -f "$downloaded_file" ]; then
    tar xzf "$downloaded_file" -C "$output_dir" fzf
  else
    echo "Couldn't find downloaded fzf tarball at $downloaded_file!"
    exit 1
  fi
}
