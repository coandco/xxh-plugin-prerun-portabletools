#!/usr/bin/env bash

tool_github_repo="so-fancy/diff-so-fancy"
tool_arch="diff-so-fancy"
tool_version="latest"

install_tool() {
  local downloaded_file="$1"
  local output_dir="$2"
  if [ -f "$downloaded_file" ]; then
    chmod a+x "$downloaded_file"
    mv "$downloaded_file" "$output_dir/"
  else
    echo "Couldn't find downloaded diff-so-fancy at $downloaded_file!"
    exit 1
  fi
}
