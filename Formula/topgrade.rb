class Topgrade < Formula
  desc "Upgrade all the things"
  homepage "https://github.com/r-darwish/topgrade"
  url "https://github.com/r-darwish/topgrade/archive/v1.7.0.tar.gz"
  sha256 "e0dc1b9e50e2f023ab6922cfd2f44e27ef307dee51047800479ec2828269702b"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf9bcc304ad23ec7c180571947ccb0c787cdbae24a55ccc6517d62dcc6f4a53f" => :mojave
    sha256 "ce6d4bf4e9c6f43619e73e42989baa493902e0fcb3401055a8fa64f35abf24e2" => :high_sierra
    sha256 "105cf7c072c4e610525a006880d687f349d09bffd0e5c19fa7aaa638e48f86b5" => :sierra
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    output = shell_output("#{bin}/topgrade -n")
    assert_match "Dry running: #{HOMEBREW_PREFIX}/bin/brew upgrade", output
    assert_not_match /\sSelf update\s/, output
  end
end
