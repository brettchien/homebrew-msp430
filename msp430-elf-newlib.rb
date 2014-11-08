require 'formula'

class Msp430ElfNewlib < Formula
  homepage 'http://sourceware.org/newlib/'
  url 'ftp://sourceware.org/pub/newlib/newlib-2.1.0.tar.gz'
  sha1 '364d569771866bf55cdbd1f8c4a6fa5c9cf2ef6c'

  def install
    target = 'msp430-elf'
    args = [
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
      "--disable-nls"
    ]

    system "./configure", *args
    system "make"
    system "make install"
  end
end