#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd -- "$script_dir/.."

# Read origin directly so stale or unpublished local tags do not affect the version.
remote_tags=$(git ls-remote --tags --refs origin)
latest_tag=$(
  printf '%s\n' "$remote_tags" |
    awk '{
      sub(/^refs\/tags\//, "", $2)
      if ($2 ~ /^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$/) print $2
    }' |
    LC_ALL=C sort -t . -k1,1n -k2,2n -k3,3n |
    tail -n 1
)

latest_tag=${latest_tag:-0.0.0}
IFS=. read -r major minor patch <<< "$latest_tag"
next_tag="$major.$minor.$((patch + 1))"

echo "远程最新版本：$latest_tag；即将推送：$next_tag（当前 HEAD）"
git tag "$next_tag" HEAD
if ! git push origin "refs/tags/$next_tag:refs/tags/$next_tag"; then
  git tag -d "$next_tag"
  echo "推送失败，已清理本次创建的本地 tag：$next_tag" >&2
  exit 1
fi

echo "已推送 tag：$next_tag"
