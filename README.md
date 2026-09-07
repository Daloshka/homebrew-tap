# Daloshka Homebrew tap

Homebrew cask for [Librium](https://github.com/Daloshka/Librium) — a free, open-source
HTTP, HTTPS and WebSocket debugging proxy for macOS and Windows.

## Install

```sh
brew install --cask --no-quarantine daloshka/tap/librium
```

`--no-quarantine` is needed because the app is ad-hoc signed rather than signed with an
Apple Developer ID: without it macOS reports Librium as damaged on first launch. If you
already installed it the normal way, clear the flag instead:

```sh
brew install --cask daloshka/tap/librium
xattr -dr com.apple.quarantine /Applications/Librium.app
```

## Update and uninstall

```sh
brew upgrade --cask librium
brew uninstall --cask librium          # keeps the CA and the history database
brew uninstall --zap --cask librium    # removes them too
```

## Requirements

Apple silicon (arm64) and macOS 13 Ventura or newer — the same minimum as the Electron
runtime Librium ships. There is no Intel build; on an Intel Mac use the
[release archive](https://github.com/Daloshka/Librium/releases) built from source.

## Maintaining

After a new Librium release:

```sh
./update.sh 0.5.5
```

The script downloads the release dmg, computes its SHA-256, rewrites `version` and
`sha256` in `Casks/librium.rb` and prints the git commands to run. It never commits or
pushes by itself.

## License

MIT, same as Librium.
