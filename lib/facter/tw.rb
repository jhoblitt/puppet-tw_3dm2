require 'facter'

Facter.add(:tw_cli) do
  confine :kernel => "Linux"
  setcode do
    Facter::Util::Resolution.which('tw_cli')
  end
end

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

# example output 3:
#
# # tw_cli show version
# CLI Version = 2.00.11.016
# API Version = 2.08.00.017
# 
# # tw_cli show
# 
# Ctl   Model        (V)Ports  Drives   Units   NotOpt  RRate   VRate  BBU
# ------------------------------------------------------------------------
# c0    9650SE-8LPML 8         8        3       0       1       1      OK       
# 

# example output 4:
#
# # tw_cli show version
# CLI Version = 2.00.06.007
# API Version = 2.03.00.006
# CLI Compatible Range = [2.00.00.001 to 2.00.06.007]
#
# # tw_cli show
#
# Ctl   Model        Ports   Drives   Units   NotOpt   RRate   VRate   BBU
# ------------------------------------------------------------------------
# c2    7506-8       8       8        2       0        3       -       -        
# c3    7506-8       8       8        2       0        3       -       -        
#


Facter.add(:tw_controllers) do
  confine :kernel => "Linux"
  setcode do
    # we can't do anything without the tw_cli utility
    tw_cli = Facter.value('tw_cli')
    unless tw_cli
      return nil
    end

    output = Facter::Util::Resolution.exec("#{tw_cli} show")

    # parse out the device name of each controller
    # controllers = ['c0','c1']
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

# example output 1:
#
# # tw_cli show version
# CLI Version = 2.00.11.020
# API Version = 2.08.00.023
# 
# # tw_cli /c8 show drivestatus
# 
# VPort Status         Unit Size      Type  Phy Encl-Slot    Model
# ------------------------------------------------------------------------------
# p0    OK             u0   136.73 GB SAS   0   -            SEAGATE ST3146356SS 
# p1    OK             u0   136.73 GB SAS   1   -            SEAGATE ST3146356SS 
# p2    OK             u0   136.73 GB SAS   2   -            SEAGATE ST3146356SS 
# p3    OK             u0   136.73 GB SAS   3   -            SEAGATE ST3146356SS 
# p4    OK             u0   136.73 GB SAS   4   -            SEAGATE ST3146356SS 
# p5    OK             u0   136.73 GB SAS   5   -            SEAGATE ST3146356SS 
# p6    OK             u0   136.73 GB SAS   6   -            SEAGATE ST3146356SS 
# p7    OK             u0   136.73 GB SAS   7   -            SEAGATE ST3146356SS 
# 

# example output 2:
#
# # tw_cli show version
# CLI Version = 2.00.11.016
# API Version = 2.08.00.017
# 
# # tw_cli /c0 show drivestatus
# 
# VPort Status         Unit Size      Type  Phy Encl-Slot    Model
# ------------------------------------------------------------------------------
# p0    OK             u0   136.73 GB SAS   0   -            SEAGATE ST3146356SS 
# p1    OK             u0   136.73 GB SAS   1   -            SEAGATE ST3146356SS 
# p2    OK             u1   136.73 GB SAS   2   -            SEAGATE ST3146356SS 
# p3    OK             u1   136.73 GB SAS   3   -            SEAGATE ST3146356SS 
# p4    OK             u1   136.73 GB SAS   4   -            SEAGATE ST3146356SS 
# p5    OK             u1   136.73 GB SAS   5   -            SEAGATE ST3146356SS 
# p6    OK             u2   136.73 GB SAS   6   -            SEAGATE ST3146356SS
# 

# example output 3:
#
# # tw_cli show version
# CLI Version = 2.00.11.016
# API Version = 2.08.00.017
# 
# # tw_cli /c0 show drivestatus
# 
# VPort Status         Unit Size      Type  Phy Encl-Slot    Model
# ------------------------------------------------------------------------------
# p0    OK             u0   931.51 GB SATA  0   -            ST31000524NS        
# p1    OK             u0   931.51 GB SATA  1   -            ST31000524NS        
# p2    OK             u1   931.51 GB SATA  2   -            ST31000524NS        
# p3    OK             u1   931.51 GB SATA  3   -            ST31000524NS        
# p4    SMART-FAILURE  u1   931.51 GB SATA  4   -            ST31000524NS        
# p5    OK             u1   931.51 GB SATA  5   -            ST31000524NS        
# p6    OK             u1   931.51 GB SATA  6   -            ST31000524NS        
# p7    OK             u2   931.51 GB SATA  7   -            ST31000524NS        
# 

# example output 4:
#
# # tw_cli show version
# CLI Version = 2.00.06.007
# API Version = 2.03.00.006
# CLI Compatible Range = [2.00.00.001 to 2.00.06.007]
# 
# # tw_cli show
# 
# Ctl   Model        Ports   Drives   Units   NotOpt   RRate   VRate   BBU
# ------------------------------------------------------------------------
# c2    7506-8       8       8        2       0        3       -       -        
# c3    7506-8       8       8        2       0        3       -       -        
# 
# [root@archive1 sbin]# tw_cli /c2 show drivestatus
# 
# Port   Status           Unit   Size        Blocks        Serial
# ---------------------------------------------------------------
# p0     OK               u0     233.76 GB   490234752     Y69GCKME            
# p1     OK               u1     233.76 GB   490234752     Y60TM1TE            
# p2     OK               u1     233.76 GB   490234752     Y648BGJE            
# p3     OK               u1     233.76 GB   490234752     Y649DYLE            
# p4     OK               u1     233.76 GB   490234752     Y649PZ2E            
# p5     OK               u1     233.76 GB   490234752     Y64A0GBE            
# p6     OK               u1     233.76 GB   490234752     Y64A0H1E            
# p7     OK               u1     233.76 GB   490234752     Y648BF9E            
# 

if Facter.value(:kernel) == "Linux"
  # we can't do anything without the tw_cli utility
  tw_cli = Facter.value('tw_cli')
  # or a list of controllers (which we wouldn't have without a working tw_cli)
  tw_controllers = Facter.value('tw_controllers')

  unless tw_cli.nil? and tw_controllers.nil?
    # iterate over each controller and get the list of attached drives
    controllers = tw_controllers.split(',') 
    controllers.each{ |unit|
      output = Facter::Util::Resolution.exec("#{tw_cli} /#{unit} show drivestatus")

      # parse out the vport # and interface type for each drive
      # drives = { 'sas' = ['0','1'] }
      drives = {}
      output.split(/\n/).each { |line|
        next if line =~ /^$/              # blank line
        next if line =~ /^\s+/            # white space only (not needed?)
        next if line =~ /^(VPort|Port)+/  # header line
        next if line =~ /^-+/             # deliminter line

        fields = line.split(/\s+/)
        vport  = fields[0]
        type   = fields[5]

        # if this is a new drive type init list of drives array
        unless drives.has_key?(type)
          drives[type] = []
        end

        # convert vport "p5" -> "5" as tw_cli is inconsitent about refering
        # to disks as "pN" or just "N" and smartctl uses just N
        drives[type].push(/^p(\d+)$/.match(vport)[1])
      }

      # create a new fact for each controller + drive type pair
      drives.each_key{ |type| 
        Facter.add(:"tw_controller_#{unit}_#{type}_drives") do
          confine :kernel => "Linux"
          setcode do
            drives[type].sort.join(',')
          end
        end
      }
    }
  end
end
