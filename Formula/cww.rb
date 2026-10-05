class Cww < Formula
  desc "Chat with Work desktop app, terminal interface and background agent"
  homepage "https://github.com/crmne/chatwithwork-local-agent"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    # Universal CLI and app bundle, signed with Developer ID and notarized.
    url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.3.1/cww-v0.3.1-macos-universal.tar.gz"
    sha256 "c66316f7201b535bfb6ecfb211e586caaeb7fad84f4fff1ec98adcb2c659cbd5"
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
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.3.1/cww-app-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9aeaaf01c23a1f7443df353e3bf34a40b69f6f1b0cc275e9038924cc53e38813"
    end
    on_arm do
      url "https://github.com/crmne/chatwithwork-local-agent/releases/download/v0.3.1/cww-app-v0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7090938f18e7312566d1fdb90f95e31d8a7692aaeae6e713e667766fa0369279"
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
