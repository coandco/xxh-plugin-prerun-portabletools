#!/usr/bin/env bash

tool_github_repo="BurntSushi/ripgrep"
tool_arch="x86_64-unknown-linux-musl"
tool_version="latest"

install_tool() {
  local downloaded_file="$1"
  local output_dir="$2"
  if [ -f "$downloaded_file" ]; then
    downloaded_basename=`basename "$downloaded_file"`
    subdir_name="${downloaded_basename%.tar.gz}"
    tar xzf "$downloaded_file" --strip-components 1 -C "$output_dir" "$subdir_name/rg"
  else
    echo "Couldn't find downloaded rg tarball at $downloaded_file!"
    exit 1
  fi
}
