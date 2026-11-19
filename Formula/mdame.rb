class Mdame < Formula
  desc "A local markdown viewer and editor, served to your browser"
  homepage "https://github.com/KamalF/mdame"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.3/mdame-aarch64-apple-darwin.tar.xz"
      sha256 "ed774d7041ca70834b58508fd232f8a36ad1f0390b67e7334572f7728f3e993b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.3/mdame-x86_64-apple-darwin.tar.xz"
      sha256 "4c644ffeabeb773c0d0edd5d84079a3c05531c4599130174092a0e6bb1f907e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.3/mdame-aarch64-unknown-linux-musl.tar.xz"
      sha256 "8400113e976f00350cc76e4cebc131dafb65044d09948e0efbaed31937f8fe81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.3/mdame-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2358f7c0ccd8f109807cf0ac76ab766096f4b73f59aff7776dc134b18c158758"
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
