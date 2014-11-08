require 'formula'

class Msp430ElfIncludes < Formula
  homepage 'http://www.ti.com/tool/msp430-gcc-opensource'
  url 'http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-support-files.zip'

  def install
    onoe 'This package is installed by msp430-elf-gcc.'
    raise ErrorDurringExecution
  end
end