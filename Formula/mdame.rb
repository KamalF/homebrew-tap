class Mdame < Formula
  desc "A local markdown viewer and editor, served to your browser"
  homepage "https://github.com/KamalF/mdame"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.1/mdame-aarch64-apple-darwin.tar.xz"
      sha256 "9c42386a705a9c492f8b3b39e550f170788ceaf59c81acc6992cd5d554ecdaa9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.1/mdame-x86_64-apple-darwin.tar.xz"
      sha256 "937eaa05ad45d3fa5551da1c30ce83c086ddd51b1e120c0f7f6c5364d00688ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.1/mdame-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b6b2e6ec762b9f32a71c9249feb75c6b97094f015fd42b04f6b2e401d40f50df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.1/mdame-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8449eb31bb23c9723741b3bdc3a01cda94edee1914b80f00b909a6c04fc26430"
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
