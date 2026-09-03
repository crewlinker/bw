#!/usr/bin/env bash
#MISE description="Tag HEAD with the next version and publish a GitHub release (CI only)"
#USAGE flag "--bump <level>" help="Version component to bump" default="patch" {
#USAGE   choices "patch" "minor" "major"
#USAGE }
set -euo pipefail

if [[ "${CI:-false}" != "true" ]]; then
	echo "ERROR: release:publish only runs in CI. Use 'mise run release:snapshot' locally." >&2
	exit 1
fi

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
	echo "ERROR: GITHUB_TOKEN must be set to create the tag and the GitHub release." >&2
	exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
	echo "ERROR: working tree is not clean; GoReleaser refuses to release from a dirty tree." >&2
	git status --porcelain >&2
	exit 1
fi

git fetch --quiet --tags origin

sha=$(git rev-parse HEAD)
tag=$(mise run --quiet release:next-version --bump "${usage_bump:-patch}")
repo=$(gh repo view --json nameWithOwner --jq .nameWithOwner)

echo "Releasing ${repo} ${tag} from ${sha}"

# Create the tag on GitHub rather than pushing it, so no git credentials are
# needed in the checkout. Tags created with GITHUB_TOKEN do not trigger other
# workflows, which is why tagging and releasing happen in this one task.
gh api --silent "repos/${repo}/git/refs" -f ref="refs/tags/${tag}" -f sha="$sha"
git fetch --quiet origin "refs/tags/${tag}:refs/tags/${tag}"

goreleaser release --clean
