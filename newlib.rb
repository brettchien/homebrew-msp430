require 'formula'

class Newlib < Formula
  homepage 'http://sourceware.org/newlib/'
  #url 'ftp://sources.redhat.com/pub/newlib/newlib-2.0.0.tar.gz'
  #sha1 'ea6b5727162453284791869e905f39fb8fab8d3f'

  url 'ftp://sourceware.org/pub/newlib/newlib-2.1.0.tar.gz'
  sha1 '364d569771866bf55cdbd1f8c4a6fa5c9cf2ef6c'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end