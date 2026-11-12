class Mdame < Formula
  desc "A local markdown viewer and editor, served to your browser"
  homepage "https://github.com/KamalF/mdame"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.2/mdame-aarch64-apple-darwin.tar.xz"
      sha256 "786369f0e45e30cce665115c0d96cf692876f9cb918e557d504fae2c109970ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.2/mdame-x86_64-apple-darwin.tar.xz"
      sha256 "e9cc0c0e39d5beffa7ace815d53707e0c854e13e0e333bde160834a46b945e5d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.2/mdame-aarch64-unknown-linux-musl.tar.xz"
      sha256 "8e916391dd04ce402ae322181b3f6030490ba6ec4d190d8dbcca5353cec0bea0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.2/mdame-x86_64-unknown-linux-musl.tar.xz"
      sha256 "53e734a521b7cbd10afca870a80e36278d306f2b644031860879a6a545393127"
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
