require 'spec_helper'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

describe 'tw_controllers fact' do
  describe 'tw_cli fact set' do
    Facter.fact(:tw_cli).stubs(:value).returns '/usr/sbin/tw_cli'
    Facter.fact(:tw_cli).value.should == '/usr/sbin/tw_cli'
    Facter::Util::Resolution.stubs(:exec).with('/usr/sbin/tw_cli show')
.returns(<<EOS)

Ctl   Model        (V)Ports  Drives   Units   NotOpt  RRate   VRate  BBU
------------------------------------------------------------------------
c8    9690SA-8I    8         8        1       0       1       1      OK       

EOS
    Facter.fact(:tw_controllers).value.should == 'c8'
  end

  describe 'tw_cli fact missing' do
    Facter.fact(:tw_controllers).value.should == nil
  end
end
