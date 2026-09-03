# bw

Sterndesk Basewarp library and the `bwrp` command line program.

## Installing `bwrp` with mise

Every merge into `main` publishes a GitHub release. Point [mise](https://mise.jdx.dev) at the repository and it picks the asset for your platform:

```toml
[tools]
"github:crewlinker/bw" = { version = "latest", minimum_release_age = "0s" }
```

```sh
mise install   # installs the latest release; `bwrp` is now on PATH
mise up        # later: update to the newest release
```

`minimum_release_age = "0s"` opts this tool out of mise's default 24-hour quarantine of new releases, so `mise up` picks up a release as soon as it is published. Drop it if you prefer the delay.

This repository is private, so mise needs a GitHub token that can read it. mise uses `GITHUB_TOKEN` or `GH_TOKEN` when set, or the token from `mise token github`.

## Releasing

Releases are automated by `.github/workflows/release.yml`, which runs `mise run release:publish` on every push to `main`. The task tags `HEAD` with the next version (a patch bump of the highest `v*` tag) and runs GoReleaser. Trigger the workflow manually with a `bump` of `minor` or `major` for larger bumps.

- `mise run check:release` validates `.goreleaser.yaml`.
- `mise run release:snapshot` builds an unpublished release into `dist/`.
- `mise run release:next-version` prints the tag the next release would get.
