class Mdame < Formula
  desc "A local markdown viewer and editor, served to your browser"
  homepage "https://github.com/KamalF/mdame"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.0/mdame-aarch64-apple-darwin.tar.xz"
      sha256 "45b6c53651773d1f093be35d960f54d8b9aca12a3ebd260457a2f8429974dfab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.0/mdame-x86_64-apple-darwin.tar.xz"
      sha256 "9997b4ad133ede86b1e8ad6fb9207e6c021a7ec8f28cb9fe03b105121b055ddf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.0/mdame-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5dc7a951dda6c80542592a2c1123089f72444262793025112d40dd64dbdb39d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KamalF/mdame/releases/download/v0.2.0/mdame-x86_64-unknown-linux-musl.tar.xz"
      sha256 "51a744ac08516ad62821c2f957c3207bf6db6411bb321af16c0eb19c31db51b9"
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
