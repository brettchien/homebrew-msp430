require 'formula'

class Msp430ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.9.2/gcc-4.9.2.tar.bz2'
  mirror 'ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.2/gcc-4.9.2.tar.bz2'
  sha1 '79dbcb09f44232822460d80b033c962c0237c6d8'

  head 'svn://gcc.gnu.org/svn/gcc/branches/gcc-4_9-branch'

  depends_on 'gmp4'
  depends_on 'libmpc08'
  depends_on 'mpfr2'
  depends_on 'cloog018'
  depends_on 'isl011'
  depends_on 'msp430-elf-binutils'

  # Fix 10.10 issues: https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=215251
  patch do
    url 'https://raw.githubusercontent.com/DomT4/scripts/6c0e48921/Homebrew_Resources/Gcc/gcc1010.diff'
    sha1 '083ec884399218584aec76ab8f2a0db97c12a3ba'
  end

  def install
    target = 'msp430-elf'
    binutils = Formula.factory "#{target}-binutils"

    ENV['PATH'] += ":#{binutils.prefix}/bin"
    gccbuildpath = buildpath

    newlib = Formula.factory 'newlib'
    newlib.brew do
      ohai 'Moving newlib into GCC build tree'
      system 'mv', 'newlib', "#{gccbuildpath}/newlib"
      ohai 'Moving libgloss into GCC build tree'
      system 'mv', 'libgloss', "#{gccbuildpath}/libgloss"
    end

    languages = %w[c c++]

    args = [
      "--target=#{target}",
      "--prefix=#{prefix}",
      "--enable-languages=#{languages.join(',')}",
      "--program-prefix=msp430-elf-",
      "--with-gmp=#{Formula["gmp4"].opt_prefix}",
      "--with-mpfr=#{Formula["mpfr2"].opt_prefix}",
      "--with-mpc=#{Formula["libmpc08"].opt_prefix}",
      "--with-cloog=#{Formula["cloog018"].opt_prefix}",
      "--with-isl=#{Formula["isl011"].opt_prefix}",
      "--with-system-zlib",
      "--disable-werror",
      "--disable-install-libiberty",
      "--with-as=#{binutils.prefix}/bin/#{target}-as",
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
