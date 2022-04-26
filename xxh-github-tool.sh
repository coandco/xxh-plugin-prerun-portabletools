#!/usr/bin/env bash

tool_github_repo="xxh/xxh"
tool_arch="Linux-x86_64"
# This doesn't have a named release -- it corresponds to tag/0.8.10-release2
tool_version="59430019"

install_tool() {
  local downloaded_file="$1"
  local output_dir="$2"
  if [ -f "$downloaded_file" ]; then
    tar xzf "$downloaded_file" -C "$output_dir" xxh
  else
    echo "Couldn't find downloaded xxh tarball at $downloaded_file!"
    exit 1
  fi
}
