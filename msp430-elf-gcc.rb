require 'formula'

class Msp430ElfGcc < Formula
  homepage 'http://gcc.gnu.org'

  url 'http://ftpmirror.gnu.org/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2'
  mirror 'ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.2/gcc-4.9.2.tar.bz2'
  sha1 '79dbcb09f44232822460d80b033c962c0237c6d8'

  # url 'http://ftpmirror.gnu.org/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2'
  # mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2'
  # sha1 '3f303f403053f0ce79530dae832811ecef91197e'

  head 'svn://gcc.gnu.org/svn/gcc/branches/gcc-4_9-branch'

  depends_on 'gmp4'
  depends_on 'libmpc08'
  depends_on 'mpfr2'
  depends_on 'cloog018'
  depends_on 'isl011'
  depends_on 'msp430-elf-binutils'

  def install
    target = 'msp430-elf'
    binutils = Formula.factory "#{target}-binutils"
    ENV['PATH'] += ":#{binutils.bin}:#{bin}"

    languages = %w[c c++]

    args = [
      "--target=#{target}",
      "--prefix=#{prefix}",
      "--enable-languages=#{languages.join(',')}",
      "--program-prefix=msp430-elf-",
      "--with-newlib",
      "CFLAGS=-std=gnu89",
    ]

    mkdir 'build'
    chdir 'build' do
      system '../configure', *args
      system 'make', 'all-host'
      system 'make', 'install-host'
    end

    newlib = Formula.factory "#{target}-newlib"
    newlib.brew do
      newlib_args = [
        "--prefix=#{prefix}",
        "--target=#{target}",
        "--disable-newlib-supplied-syscalls",
        "--enable-newlib-reent-small",
        "--disable-newlib-fseek-optimization",
        "--disable-newlib-wide-orient",
        "--enable-newlib-nano-formatted-io",
        "--disable-newlib-io-float",
        "--enable-newlib-nano-malloc",
        "--disable-newlib-unbuf-stream-opt",
        "--enable-lite-exit",
        "--enable-newlib-global-atexit",
        "--disable-nls",
        "--with-as=#{binutils.bin}/#{target}-as"
      ]

      system "./configure", *newlib_args
      system "make"
      system "make install"
    end

    chdir 'build' do
      system '../configure', *args
      system 'make', 'all-target'
      system 'make', 'install-target'
    end

    info.rmtree
  end
end
