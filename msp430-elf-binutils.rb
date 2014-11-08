require 'formula'

class Msp430ElfBinutils < Formula
  homepage 'http://www.gnu.org/software/binutils/binutils.html'

  # No --default-names option as it interferes with Homebrew builds.

  url "git://sourceware.org/git/binutils-gdb.git", :using => :git, :branch => "binutils-2_25-branch"

  def install
    target = 'msp430-elf'
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--program-prefix=#{target}-",
                          "--infodir=#{info}",
                          "--mandir=#{man}",
                          "--libdir=#{lib}",
                          "--disable-werror",
                          "--enable-interwork",
                          "--enable-multilib",
                          "--enable-64-bit-bfd",
                          "--disable-nls",
                          "--enable-install-libbfd",
                          "--target=#{target}"
    system "make"
    system "make", "install"

    info.rmtree
  end
end
