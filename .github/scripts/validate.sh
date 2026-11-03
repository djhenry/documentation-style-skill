#!/usr/bin/env bash
# Check that SKILL.md has well-formed frontmatter with the required fields.
set -euo pipefail
f="${1:-SKILL.md}"
[ "$(sed -n 1p "$f")" = "---" ] || { echo "$f: missing opening frontmatter fence"; exit 1; }
fm="$(awk 'NR>1 && /^---$/ {exit} NR>1 {print}' "$f")"
[ -n "$fm" ] || { echo "$f: empty or unterminated frontmatter"; exit 1; }
for key in name description version; do
  echo "$fm" | grep -q "^$key:" || { echo "$f: frontmatter missing '$key'"; exit 1; }
done
grep -q '^# ' "$f" || { echo "$f: missing top-level heading"; exit 1; }
echo "$f: ok"
