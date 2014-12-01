class Msp430Gcc < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://gnu.askapache.com/gcc/gcc-4.7.3/gcc-4.7.3.tar.bz2'
  
  depends_on 'msp430-binutils'

  fails_with :clang
  fails_with :llvm

  # mspgcc special sauce
  patch do
    url 'http://sourceforge.net/projects/mspgcc/files/Patches/gcc-4.7.0/msp430-gcc-4.7.0-20120911.patch'
    sha1 '3e70230f6052ed30d1a288724f2b97ab47581489'
  end

  # host CFLAGS shouldn't be inherited by target
  #patch :DATA

  def caveats; <<-EOS.unindent
    Installing this package along side gcc has been known to result in linking errors.
    The following is a workaround for dealing with those linking errors:
      brew unlink gcc
      mkdir /usr/local/lib/gcc
      brew link gcc
      brew link mspgcc
    EOS
  end

  def install
    target='msp430'
    binutils = Formula.factory "#{target}-binutils"
    ENV['PATH'] += ":#{binutils.bin}:#{bin}"

    args = [
      "--target=msp430",
      "--program-prefix='msp'",
      "--prefix=#{prefix}",
      "--enable-languages=c,c++",
      "--with-as=#{binutils.bin}/#{target}-as",
      "--with-ld=#{binutils.bin}/#{target}-ld",
    ]

    mkdir 'build' do
      system "../configure", *args
      system "make"
      system "make install"
    end

    # Remove libiberty, which conflicts with the same library provided by
    # binutils.
    # http://msp430-gcc-users.1086195.n5.nabble.com/overwriting-libiberty-td4215.html
    # Fix inspired by:
    # https://github.com/larsimmisch/homebrew-avr/commit/8cc2a2e591b3a4bef09bd6efe2d7de95dfd92794
    multios = `gcc --print-multi-os-directory`.chomp
    File.unlink "#{prefix}/lib/#{multios}/libiberty.a"
  end
end
