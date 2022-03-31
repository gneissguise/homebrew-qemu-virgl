class Virglrenderer < Formula
  desc "VirGL virtual OpenGL renderer"
  homepage "https://gitlab.freedesktop.org/virgl/virglrenderer"
  url "https://gitlab.freedesktop.org/virgl/virglrenderer.git", revision: "453017e32ace65fa2f9c908bd5a9721f65fbf2a2"
  version "20211212.1"
  license "MIT"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gneissguise/qemu-virgl/libangle"
  depends_on "gneissguise/qemu-virgl/libepoxy-angle"

  # waiting for upstreaming of https://github.com/akihikodaki/virglrenderer/tree/macos
  patch :p1 do
    url "https://github.com/gneissguise/homebrew-qemu-virgl/blob/master/Patches/virglrenderer-v04.diff"
    sha256 "c8acb0cd3f4e43d3e162c7ca00894350fde3c2610c3f3bfc47667ba8a829d014"
  end

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Dc_args=-I#{Formula["libepoxy-angle"].opt_prefix}/include",
             "-Dc_link_args=-L#{Formula["libepoxy-angle"].opt_prefix}/lib", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "true"
  end
end
