#!/usr/bin/env bash
#MISE description="Print the next release tag, bumped from the highest v* tag"
#USAGE flag "--bump <level>" help="Version component to bump" default="patch" {
#USAGE   choices "patch" "minor" "major"
#USAGE }
set -euo pipefail

bump="${usage_bump:-patch}"

latest=$(git tag --list 'v[0-9]*.[0-9]*.[0-9]*' --sort=-v:refname | head -n 1)
latest="${latest:-v0.0.0}"

IFS=. read -r major minor patch <<<"${latest#v}"

case "$bump" in
major)
	major=$((major + 1))
	minor=0
	patch=0
	;;
minor)
	minor=$((minor + 1))
	patch=0
	;;
patch)
	patch=$((patch + 1))
	;;
*)
	echo "ERROR: unknown bump level '$bump' (expected patch, minor, or major)" >&2
	exit 1
	;;
esac

echo "v${major}.${minor}.${patch}"
