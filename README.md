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

`minimum_release_age = "0s"` opts this tool out of mise's default 24-hour quarantine of new releases. Drop it if you prefer the delay.

mise caches the list of remote versions for an hour, so `mise up` may not see a release published minutes ago. To update to a release that was just merged, bypass the cache:

```sh
MISE_FETCH_REMOTE_VERSIONS_CACHE=0s mise up
```

mise queries the GitHub API for releases. Unauthenticated requests are rate limited, so set `GITHUB_TOKEN` or `GH_TOKEN`, or run `mise token github`, if you hit the limit.

## Releasing

Releases are automated by `.github/workflows/release.yml`, which runs `mise run release:publish` on every push to `main`. The task tags `HEAD` with the next version (a patch bump of the highest `v*` tag) and runs GoReleaser. Trigger the workflow manually with a `bump` of `minor` or `major` for larger bumps.

- `mise run check:release` validates `.goreleaser.yaml`.
- `mise run release:snapshot` builds an unpublished release into `dist/`.
- `mise run release:next-version` prints the tag the next release would get.

## License

This repository is licensed under the [Functional Source License, Version 1.1, MIT Future License](LICENSE.md) (FSL-1.1-MIT). You may use, modify and redistribute the code for any purpose except a Competing Use, and each version becomes available under the MIT license two years after its release.
