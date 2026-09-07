cask "librium" do
  version "0.5.4"
  sha256 "37aaf2528ec3f1f466bc797df3e832eb2449fc476d47a09e25b82b93500a5699"

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
