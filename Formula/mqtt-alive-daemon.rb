class MqttAliveDaemon < Formula
  desc "Reports machine aliveness and custom command checks to Home Assistant via MQTT"
  homepage "https://github.com/crmne/mqtt-alive-daemon"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/crmne/mqtt-alive-daemon/releases/download/v0.4.1/mqtt-alive-daemon_0.4.1_darwin_amd64.tar.gz"
      sha256 "670dabf5bfd2b5e5c02abda9da6487bfa00a1e589b43b7c64566d6f992df6218"
    end
    on_arm do
      url "https://github.com/crmne/mqtt-alive-daemon/releases/download/v0.4.1/mqtt-alive-daemon_0.4.1_darwin_arm64.tar.gz"
      sha256 "52afbc6b7aff965d72a7df9a21da64609e9a8930e42276538f79217fd116930f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/crmne/mqtt-alive-daemon/releases/download/v0.4.1/mqtt-alive-daemon_0.4.1_linux_amd64.tar.gz"
      sha256 "bb1af2050f7aa211961f1bf21c9cd6648591eab2ec9d2c08e5073ee6e44fd3b3"
    end
    on_arm do
      url "https://github.com/crmne/mqtt-alive-daemon/releases/download/v0.4.1/mqtt-alive-daemon_0.4.1_linux_arm64.tar.gz"
      sha256 "9a4c2c051a2680205e0cd505fd230d2fe7b332470f214f7a25e856f43c906d5e"
    end
  end

  def install
    bin.install "mqtt-alive-daemon"
    (etc/"mqtt-alive-daemon").install "config.yaml.example"
  end

  def caveats
    <<~EOS
      Create your config before starting the service:
        mkdir -p ~/.config/mqtt-alive-daemon
        install -m 600 $(brew --prefix)/etc/mqtt-alive-daemon/config.yaml.example ~/.config/mqtt-alive-daemon/config.yaml
      then edit it with your MQTT broker details and run:
        brew services start mqtt-alive-daemon
    EOS
  end

  service do
    run [opt_bin/"mqtt-alive-daemon"]
    keep_alive true
    log_path var/"log/mqtt-alive-daemon.log"
    error_log_path var/"log/mqtt-alive-daemon.error.log"
  end

  test do
    assert_predicate bin/"mqtt-alive-daemon", :exist?
  end
end
