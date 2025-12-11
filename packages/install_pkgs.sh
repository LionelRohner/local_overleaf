#!/bin/bash

set -euo pipefail

# Vars
file="pkg_requirements.txt"
container_name="sharelatex"

# Checks

if ! [[ -f "$file" ]]; then
  echo "The file $file does not exist." >&2
  exit 1
fi

if ! docker container inspect -f '{{.State.Running}}' "$container_name" >/dev/null; then
  echo "Error: Container $container_name is not running." >&2
  exit 1
fi

# Determine packages that are not installed
mapfile -t installed_pkgs < <(
  docker exec "$container_name" tlmgr list --only-installed --data name
)

declare -A installed_map
for pkg in "${installed_pkgs[@]}"; do
  installed_map["$pkg"]=1
done

# Use for loop with map instead?
# mapfile -t desired_pkgs <"$file"

# Update tlmgr
docker exec "$container_name" tlmgr update --self

# Loop through each package in the file
while IFS= read -r pkg; do

  if [[ -n "${installed_map[$pkg]:-}" ]]; then
    echo "Package $pkg is already installed."
    # TODO: Update pkg instead? maybe add a `force_update` param?
  else
    echo "Installing package: $pkg"
    docker exec "$container_name" tlmgr install "$pkg"
    #
  fi

done <"$file"
