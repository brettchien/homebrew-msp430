class Msp430Binutils < Formula
  homepage 'http://mspgcc.sourceforge.net'
  url 'http://ftpmirror.gnu.org/binutils/binutils-2.22.tar.bz2'
  sha1 '65b304a0b9a53a686ce50a01173d1f40f8efe404'

  # mspgcc special sauce
  patch do
    url 'http://sourceforge.net/projects/mspgcc/files/Patches/binutils-2.22/msp430-binutils-2.22-20120911.patch'
    sha1 '5b3aec605f85fea81a22aa52e9900a5e2f9cc460'
  end

  def install
    system "./configure", "--target=msp430", "--program-prefix='msp430-'", "--prefix=#{prefix}"
    system "make"
    system "make install"

    info.rmtree
    share.rmtree
  end
end