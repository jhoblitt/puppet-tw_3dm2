require 'spec_helper'

RSpec.configure do |c|
  c.include PuppetlabsSpec::Files

  c.before :each do
    # Ensure that we don't accidentally cache facts and environment
    # between test cases.
    Facter::Util::Loader.any_instance.stubs(:load_all)
    Facter.clear
    Facter.clear_messages

    # Store any environment variables away to be restored later
    @old_env = {}
    ENV.each_key {|k| @old_env[k] = ENV[k]}
  end

  c.after :each do
    PuppetlabsSpec::Files.cleanup
  end
end

describe 'tw_cli fact', :type => :fact  do

  describe 'on linux' do
    it "should find the tw_cli binary" do
      Facter.fact(:kernel).stubs(:value).returns('Linux')
      Facter::Util::Resolution.stubs(:which).with('tw_cli').returns('/usr/sbin/tw_cli')

      Facter.fact(:tw_cli).value.should == '/usr/sbin/tw_cli'
    end

    it "should not find the tw_cli binary" do
      Facter.fact(:kernel).stubs(:value).returns('Linux')
      Facter::Util::Resolution.stubs(:which).with('tw_cli').returns(nil)

      Facter.fact(:tw_cli).should == nil
    end
  end
  
  describe 'on no kernel' do
    it "should not find the tw_cli binary" do
      Facter::Util::Resolution.stubs(:which).with('tw_cli').returns('/usr/sbin/tw_cli')
      Facter.fact(:tw_cli).value.should == nil
    end
  
    it "should not find the tw_cli binary" do
      Facter.fact(:tw_cli).value.should == nil
    end
  end
end
