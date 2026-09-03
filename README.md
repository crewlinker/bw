# bw

Sterndesk Basewarp library and the `bwrp` command line program.

## Installing `bwrp` with mise

Every merge into `main` publishes a GitHub release. Point [mise](https://mise.jdx.dev) at the repository and it picks the asset for your platform:

```toml
[tools]
"github:crewlinker/bw" = "latest"
```

```sh
mise install   # installs the latest release; `bwrp` is now on PATH
mise up        # later: update to the newest release
```

This repository is private, so mise needs a GitHub token that can read it. mise uses `GITHUB_TOKEN` or `GH_TOKEN` when set, or the token from `mise token github`.

If your mise configuration sets `minimum_release_age`, add `github:crewlinker/bw` to `minimum_release_age_excludes` to receive new releases immediately.

## Releasing

Releases are automated by `.github/workflows/release.yml`, which runs `mise run release:publish` on every push to `main`. The task tags `HEAD` with the next version (a patch bump of the highest `v*` tag) and runs GoReleaser. Trigger the workflow manually with a `bump` of `minor` or `major` for larger bumps.

- `mise run check:release` validates `.goreleaser.yaml`.
- `mise run release:snapshot` builds an unpublished release into `dist/`.
- `mise run release:next-version` prints the tag the next release would get.
