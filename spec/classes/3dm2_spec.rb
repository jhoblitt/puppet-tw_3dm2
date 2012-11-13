require 'spec_helper'

describe 'tw_3dm2' do
  let(:title) { 'redhat' }
  let(:facts) { {:osfamily=> 'RedHat'} }

  context 'with package_url & package_filename' do
    let(:params) { {:package_url=> 'http://example.org/file.zip', :package_filename => 'file.zip'} }
    it do
      should include_class('tw_3dm2') 
      should contain_file('/etc/3dm2/3dm2.conf') 
    end
  end
end
