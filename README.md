# Daloshka Homebrew tap

Homebrew cask for [Librium](https://github.com/Daloshka/Librium) — a free, open-source
HTTP, HTTPS and WebSocket debugging proxy for macOS and Windows.

## Install

```sh
brew install --cask daloshka/tap/librium
xattr -dr com.apple.quarantine /Applications/Librium.app
```

The second command is needed once after every install or upgrade: the app is ad-hoc
signed rather than signed with an Apple Developer ID, and Homebrew keeps the quarantine
attribute on downloaded apps, so without it macOS reports Librium as damaged on first
launch.

## Update and uninstall

```sh
brew upgrade --cask librium
brew uninstall --cask librium          # keeps the CA and the history database
brew uninstall --zap --cask librium    # removes them too
```

## Requirements

Apple silicon (arm64) and macOS 13 Ventura or newer — the same minimum as the Electron
runtime Librium ships. There is no Intel build yet; on an Intel Mac build Librium
[from source](https://github.com/Daloshka/Librium#from-source) — `npm run dist` produces an
x64 dmg.

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
