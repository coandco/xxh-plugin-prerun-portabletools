#!/usr/bin/env bash

main() {
	need_cmd curl
	need_cmd grep
	need_cmd chmod
	need_cmd find
	build
}

build() {
  CDIR="$(cd "$(dirname "$0")" && pwd)"
  build_dir=$CDIR/build

  while getopts A:K:q option
  do
    case "${option}"
    in
      q) QUIET=1;;
      A) ARCH=${OPTARG};;
      K) KERNEL=${OPTARG};;
    esac
  done

  rm -rf $build_dir
  mkdir -p $build_dir

  for f in *prerun.sh *pluginrc.*; do
      cp $CDIR/$f $build_dir/
  done

  mkdir -p "$build_dir/bin"

  find . -type f -name "*-github-tool.sh" -print0 | while IFS= read -r -d '' f; do
    required_vars=(tool_github_repo tool_arch tool_version install_tool)
    for required_var in "${required_vars[@]}"; do
      unset "$required_var"
    done

    tool_name="${f%-github-tool.sh}"
    echo "Attempting to install $tool_name..."

    # Import tool definition and verify that it defined the correct vars
    source "$f"
    for required_var in "${required_vars[@]}"; do
      if [ "$(type -t "$required_var")" == "function" ] || [ -n "${!required_var}" ]; then
        continue
      fi
      echo "Required var $required_var not found in file $f"
      exit 1
    done

    release_url="https://api.github.com/repos/${tool_github_repo}/releases/${tool_version}"
    regex_before='https.*'
    regex_after='[^"]*'
    download_url=`curl -s "$release_url" | grep "browser_download_url" | grep -wo "${regex_before}${tool_arch}${regex_after}" | head -n 1`
    output_filename=`basename "$download_url"`
    echo "Downloading $download_url to $build_dir/$output_filename..."
    curl -Ls "$download_url" -o "$build_dir/$output_filename"
    echo "Installing $tool_name..."
    install_tool "$build_dir/$output_filename" "$build_dir/bin"
    rm -f "$build_dir/$output_filename"
  done

}

cmd_chk() {
  >&2 echo Check "$1"
	command -v "$1" >/dev/null 2>&1
}

need_cmd() {
  if ! cmd_chk "$1"; then
    error "need $1 (command not found)"
    exit 1
  fi
}

main "$@" || exit 1
