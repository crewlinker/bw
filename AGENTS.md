**Tasks:** Every repository workflow is a mise task in `.mise-tasks/<group>/<name>.sh`, run as `mise r <group>:<name>`. Each task is Bash with a `#MISE description="..."` header and `set -euo pipefail`; declare dependencies with `#MISE depends=[...]`. A task's `#USAGE` specification is its complete interface. Do not pass arbitrary arguments through with `"$@"`. Repository tooling is pinned in `mise.toml`.

**Shell scripts:** Keep shell scripts compatible with macOS system Bash 3.2 so they also run on newer Bash releases. Avoid Bash 4+ features such as associative arrays, `mapfile`, `${var,,}`, and `&>>`. Use shfmt's default formatting; `dev:fmt` applies it.

**Go:** This repository is a single Go module, `github.com/crewlinker/bw`, with no workspace. The root package `bw` and its subpackages are the library; `cmd/bwrp` is the only `main` package and must stay a thin entrypoint over the library. Use `github.com/cockroachdb/errors` for errors instead of the standard `errors` package; golangci-lint enforces this. When compiling only to check a build, write the artifact to a temporary directory or use `go vet ./...`; never run a bare `go build` that leaves a binary in the repository.

**Checks:** After changes, run `mise run 'check:*'`. `check:changes` runs `dev:fmt` and, under `CI=true`, fails when formatting or module metadata differs from the checked-in tree.

**Releases:** Every push to `main` runs `.github/workflows/release.yml`, which runs the checks and then `mise run release:publish`: it tags `HEAD` with the next `v*` version (patch bump by default; `workflow_dispatch` can request `minor` or `major`) and publishes the GitHub release with GoReleaser from `.goreleaser.yaml`. Consumers install the CLI with mise as `"github:crewlinker/bw" = "latest"`, so release assets must stay one archive per OS/arch with the default GoReleaser naming. Never create `v*` tags by hand. Use `mise run release:snapshot` to try the release build locally.

**Linear:** Repository tasks and issues are tracked in the [Sterndesk Basewarp project](https://linear.app/crewlinker/project/sterndesk-basewarp-27b0e6e9da03/overview) of the Engineering (`ENG`) team. Use the Linear MCP tools to read, create, and update them.

**GitHub:** All changes must go through a GitHub pull request. Every pull request must be backed by a Linear issue. If the current session does not specify one, create an ad hoc issue in the Linear project before opening the pull request. Use the Git branch name provided by the backing Linear issue, whether it was specified in the session or created ad hoc. Keep the issue description and title up to date with the work completed in the repository.
    - Never commit, push, open a Linear issue, or open a pull request without the user's explicit consent in the current session. The requirement that changes go through a pull request is not that consent; ask first.
    - Never push commits directly to `main`. Merge pull requests with rebase only; do not use merge commits or squash merges.
    - Delete the pull request branch after it is merged.
