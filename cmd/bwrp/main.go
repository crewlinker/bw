// Command bwrp is the Sterndesk Basewarp command line program.
package main

import (
	"fmt"
	"os"
)

// Build information, injected by GoReleaser through -ldflags at release time.
var (
	version = "dev"
	commit  = "none"
	date    = "unknown"
)

func main() {
	fmt.Fprintf(os.Stdout, "Hello from bwrp %s (commit %s, built %s)\n", version, commit, date)
}
