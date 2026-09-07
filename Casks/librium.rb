cask "librium" do
  version "0.6.0"
  sha256 "a0e4c219620194e393689c81b9487ebb9a28395962814a0cdeb10753d1b9459c"

  url "https://github.com/Daloshka/Librium/releases/download/v#{version}/Librium-#{version}-arm64.dmg"
  name "Librium"
  desc "HTTP, HTTPS and WebSocket debugging proxy"
  homepage "https://github.com/Daloshka/Librium"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Librium.app"

  uninstall quit: "local.librium.desktop"

  zap trash: [
    "~/Library/Application Support/Librium",
    "~/Library/Application Support/librium-desktop",
    "~/Library/Preferences/local.librium.desktop.plist",
    "~/Library/Saved Application State/local.librium.desktop.savedState",
  ]

  caveats <<~EOS
    Librium is ad-hoc signed, not signed with an Apple Developer ID, so
    macOS reports the app as damaged on first launch. Clear the quarantine
    flag once after every install or upgrade:

      xattr -dr com.apple.quarantine /Applications/Librium.app
  EOS
end
