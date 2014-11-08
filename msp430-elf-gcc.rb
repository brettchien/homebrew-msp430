require 'formula'

class Msp430ElfGcc < Formula
  def arch
    if Hardware::CPU.type == :intel
      if MacOS.prefer_64_bit?
        'x86_64'
      else
        'i686'
      end
    elsif Hardware::CPU.type == :ppc
      if MacOS.prefer_64_bit?
        'powerpc64'
      else
        'powerpc'
      end
    end
  end

  def osmajor
    `uname -r`.chomp
  end

  homepage 'http://gcc.gnu.org'
  url "http://ftpmirror.gnu.org/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2"
  mirror "ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.1/gcc-4.9.1.tar.bz2"
  sha1 "3f303f403053f0ce79530dae832811ecef91197e"

  head 'svn://gcc.gnu.org/svn/gcc/branches/gcc-4_9-branch'

  depends_on 'gmp4'
  depends_on 'libmpc08'
  depends_on 'mpfr2'
  depends_on 'cloog018'
  depends_on 'isl011'

  # Fix 10.10 issues: https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=215251
  patch do
    url "https://raw.githubusercontent.com/DomT4/scripts/6c0e48921/Homebrew_Resources/Gcc/gcc1010.diff"
    sha1 "083ec884399218584aec76ab8f2a0db97c12a3ba"
  end

  def install
    ENV['PATH'] += ":/usr/local/Cellar/msp430-elf-binutils/gdb/bin/"

    languages = %w[c c++]

    args = [
      "--prefix=#{prefix}",
      "--enable-languages=#{languages.join(',')}",
      "--program-prefix=msp430-elf-",
      "--with-gmp=#{Formula["gmp4"].opt_prefix}",
      "--with-mpfr=#{Formula["mpfr2"].opt_prefix}",
      "--with-mpc=#{Formula["libmpc08"].opt_prefix}",
      "--with-cloog=#{Formula["cloog018"].opt_prefix}",
      "--with-isl=#{Formula["isl011"].opt_prefix}",
      "--with-system-zlib",
      "--target=msp430-elf",
      "--disable-werror",
      "--disable-install-libiberty",
      "CFLAGS=-std=gnu89",
    ]

    mkdir 'build' do
      system '../configure', *args
      system 'make all'
      system 'make installdirs'
      system 'make install-target'
      system 'make install-host'
    end

    info.rmtree
  end
end
