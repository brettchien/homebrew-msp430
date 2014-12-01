re 'formula'

class MspDebugFormula < Formula
    homepage 'http://mspdebug.sourceforge.net'
    url 'http://sourceforge.net/projects/mspdebug/files/mspdebug-0.22.tar.gz'
    sha1 'f55692d90ccb1f3686e94df53e5e30408fde963f'
    env :std

    def patches
    end

    def install
        system "make"
        system "make install"
    end
end
