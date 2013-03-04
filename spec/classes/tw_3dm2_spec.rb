require 'spec_helper'

describe 'tw_3dm2' do
  let(:title) { 'redhat' }
  let(:facts) { {:osfamily=> 'RedHat', :domain => 'example.org'} }

  context 'with package_url & package_filename' do
    let(:params) {{
      :package_url      => 'http://example.org/file.zip',
      :package_filename => 'file.zip',
    }}
    it do
      should include_class('tw_3dm2') 
      should contain_file('/etc/3dm2/3dm2.conf') 
      should contain_service('tdm2') 
      should contain_file('/root/3ware').with({ 'ensure' => 'directory' }) 
    end
  end

  context 'with package_url & package_filename & emailserver' do
    let(:params) {{
      :package_url      => 'http://example.org/file.zip',
      :package_filename => 'file.zip',
      :emailserver      => '10.10.10.10',
    }}
    it do
      should include_class('tw_3dm2') 
      should contain_file('/etc/3dm2/3dm2.conf') 
      should contain_service('tdm2') 
      should contain_file('/root/3ware').with({ 'ensure' => 'directory' }) 
    end
  end

  context 'with package_url & package_filename & unzip_path' do
    let(:params) {{
      :package_url      => 'http://example.org/file.zip',
      :package_filename => 'file.zip',
      :unzip_path       => '/foo/bar/baz',
    }}
    it do
      should include_class('tw_3dm2') 
      should contain_file('/etc/3dm2/3dm2.conf') 
      should contain_service('tdm2') 
      should contain_file('/foo/bar/baz').with({ 'ensure' => 'directory' }) 
    end
  end

  context 'with no params' do
    it do
      expect {
        should include_class('tw_3dm2') 
      }.to raise_error(Puppet::Error, /^Must pass package_url/)
    end
  end

  context 'with package_url' do
    let(:params) {{
      :package_url      => 'http://example.org/file.zip',
    }}
    it do
      expect {
        should include_class('tw_3dm2') 
      }.to raise_error(Puppet::Error, /^Must pass package_filename/)
    end
  end

  context 'with package_filename' do
    let(:params) {{
      :package_filename => 'file.zip',
    }}
    it do
      expect {
        should include_class('tw_3dm2') 
      }.to raise_error(Puppet::Error, /^Must pass package_url/)
    end
  end

  context 'unsupported $::operatingsystem' do
    let(:facts) { {:osfamily=> 'Debian', :domain => 'example.org'} }
    let(:params) {{
      :package_url      => 'http://example.org/file.zip',
      :package_filename => 'file.zip',
    }}
    it do
      expect {
        should include_class('tw_3dm2') 
      }.to raise_error(Puppet::Error, /^Module tw_3dm2 is not supported/)
    end
  end
end
