class Nsh < Formula
  desc "SSH host manager for macOS"
  homepage "https://github.com/kitdot/nsh"
  url "https://github.com/kitdot/nsh/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "282e5ffa9d3723aac715f14a8e242d57c4b3611018eddd4579f61d85c59d3bee"
  license "MIT"

  depends_on "go" => :build

  def install
    odie "nsh is macOS-only" unless OS.mac?

    ENV["CGO_ENABLED"] = "1"
    ldflags = "-s -w -X github.com/kitdot/nsh/cmd.nshVersion=#{version}"
    system "go", "build", *std_go_args(ldflags:), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nsh -v")
  end
end
