require 'facter'

Facter.add(:tw_cli) do
  confine :kernel => "Linux"
  setcode do
    Facter::Util::Resolution.which('tw_cli')
  end
end

Facter.add(:tw_controllers) do
  confine :kernel => "Linux"
  setcode do
    tw_cli = Facter.value('tw_cli')
    unless tw_cli
       return nil
    end

    output = Facter::Util::Resolution.exec("#{tw_cli} show")

# example output 1:
#
# # tw_cli show version
# CLI Version = 2.00.11.020
# API Version = 2.08.00.023
#
# # tw_cli show
#
# Ctl   Model        (V)Ports  Drives   Units   NotOpt  RRate   VRate  BBU
# ------------------------------------------------------------------------
# c8    9690SA-8I    8         8        1       0       1       1      OK       
#

# example output 2:
#
# # tw_cli show version
# CLI Version = 2.00.11.016
# API Version = 2.08.00.017
# 
# # tw_cli show
# 
# Ctl   Model        (V)Ports  Drives   Units   NotOpt  RRate   VRate  BBU
# ------------------------------------------------------------------------
# c0    9750-8i      7         7        3       0       1       1      OK       
# 

    controllers = []
    output.split(/\n/).each { |line|
      next if line =~ /^$/    # blank line
      next if line =~ /^\s+/  # white space only (may not be needed)
      next if line =~ /^Ctl+/ # header line
      next if line =~ /^-+/   # deliminter line
      controllers.push(line.split(/\s+/)[0])
    }

    controllers.sort.join(',')
  end
end

#if Facter.value(:kernel) == "Linux"
#  if tw_controllers = Facter.value('tw_controllers')
#    controllers = tw_controllers.split(',') 
#    controllers.each{ |unit|
#    }
#  end
#end
