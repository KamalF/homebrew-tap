class Mdame < Formula
  desc "A local markdown viewer and editor, served to your browser"
  homepage "https://github.com/KamalF/mdame"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.1.0/mdame-aarch64-apple-darwin.tar.xz"
      sha256 "8b718d72c2ed666d0b9b5b69536a05f5da668e6b6119144afe7dc013c72bae5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.1.0/mdame-x86_64-apple-darwin.tar.xz"
      sha256 "6baee1a7104d952ed944d8e1bc6d9b3aedaae28f191c5d532bfe0cc90ff450f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.1.0/mdame-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1ac82d7d648cb3f87eba9a774f1c2240eb755bd17859272f0e01eee057ee3557"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.1.0/mdame-x86_64-unknown-linux-musl.tar.xz"
      sha256 "587520d629394f999a81f4056ce431dbc1cb278b9d8605539ea033caad3fdf2a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mdame"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mdame"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mdame"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mdame"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
