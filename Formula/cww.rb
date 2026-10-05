class Cww < Formula
  desc "Chat with Work desktop app, terminal interface and background agent"
  homepage "https://github.com/crmne/chatwithwork-local-agent"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    # Universal CLI and app bundle, signed with Developer ID and notarized.
    url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.3.0/cww-v0.3.0-macos-universal.tar.gz"
    sha256 "6c048b06d57fd096b376bf0b65b293c5b178687165c9166a5cb07a85e185fae3"
  end

  on_linux do
    depends_on "libglvnd"
    depends_on "libx11"
    depends_on "libxcursor"
    depends_on "libxi"
    depends_on "libxrandr"
    depends_on "libxkbcommon"
    depends_on "wayland"
    on_intel do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.3.0/cww-app-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d96dcd5da91e4badbf849a0da8a034e3d907f6bdb123a20e9f818e5d1a650d3"
    end
    on_arm do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.3.0/cww-app-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9408bee5b5b49de83b5693b15079d04d2bf49279ec10595539e3f69c55257fbb"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    if OS.mac?
      prefix.install "Chat with Work.app"
      # Both entry points must resolve to the same cww, so daemon install
      # registers Homebrew's stable bin path instead of a versioned Cellar path.
      bin.install_symlink prefix/"Chat with Work.app/Contents/MacOS/cww"
      bin.install_symlink prefix/"Chat with Work.app/Contents/MacOS/cww-app"
    else
      bin.install "cww"
      libexec.install "cww-app"
      libexec.install_symlink bin/"cww"
      graphics = %w[libglvnd libx11 libxcursor libxi libxrandr libxkbcommon wayland]
      (bin/"cww-app").write_env_script libexec/"cww-app",
        LD_LIBRARY_PATH: graphics.map { |name| Formula[name].opt_lib }.join(":")
      # A desktop launcher does not inherit Homebrew's shell environment.
      inreplace "cww-app.desktop", "Exec=cww-app", "Exec=#{opt_bin}/cww-app"
      (share/"applications").install "cww-app.desktop"
      (share/"icons/hicolor/scalable/apps").install "cww-app.svg"
    end
    doc.install "README.md", "PROTOCOL.md", "SECURITY.md"
  end

  def caveats
    <<~EOS
      Open the desktop app with cww-app, or run cww for the terminal interface.
      Choose Start Local Agent in the app, or start it now and at login with:
        cww daemon install
      Check it with cww status. Nothing is shared until you pair and choose a folder.

      To make the app discoverable in your desktop's applications menu:
        macOS: use brew install --cask crmne/tap/chat-with-work
        Linux: add #{HOMEBREW_PREFIX}/share to XDG_DATA_DIRS in your desktop session
      Without a user service manager, run cww daemon run in a terminal.
    EOS
  end

  service do
    run [opt_bin/"cww", "daemon", "run"]
    keep_alive successful_exit: false
    process_type :background
    log_path var/"log/cww.log"
    error_log_path var/"log/cww.log"
  end

  test do
    assert_match "cww #{version}", shell_output("#{bin}/cww --version")
    assert_match version.to_s, shell_output("#{bin}/cww-app --version")
    ENV["CWW_HOME"] = testpath/"cww"
    assert_match "not running", shell_output("#{bin}/cww status")
  end
end
