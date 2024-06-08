#!/bin/bash -e
# for each file in this repo (other than this one and README)
#   move any existing file under the same relative path under the home dir out of the way
#   link the repo file into its place

for file in `find -type f | grep -v '^\./\.git/' | sed 's:^\./::g'`; do
  [ "$file" == "README.md" -o "$file" == "install.sh" ] && continue

  home_path="$HOME/$file"
  repo_path="$PWD/$file"
  home_dir=$(dirname "$home_path")
  if [ -f "$home_path" ]; then
    mv "$home_path" "$home_path.bak" || {
      echo 1>&2 "$0: Failed to move '$home_path' to '$home_path.bak'; skipping "$file"..."
      continue
    }

    echo "$0: Backed up '$home_path'."
  elif [ ! -d "$home_dir" ]; then
    mkdir -p "$home_dir" || {
      echo 1>&2 "$0: Failed to create directory '$home_dir'; skipping '$file'..."
      continue
    }
  fi

  ln -sf "$repo_path" "$home_path" || {
    echo 1>&2 "$0: Failed to link '$repo_path' to '$home_path'; skipping '$file'..."

    if [ -f "$home_path.bak" ]; then
      mv "$home_path.bak" "$home_path" || {
        echo 1>&2 "$0: Failed to RESTORE '$home_path.bak'! Please manually restore the file to '$home_path'. Aborting..."
        exit 2
      }

      echo 1>&2 "$0: Restored '$home_path'."
      continue
    fi
  }

  echo "$0: Linked '$file'"
done
