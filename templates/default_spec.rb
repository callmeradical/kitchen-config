require 'spec_helper'
## see https://github.com/sethvargo/chefspec

# using chef client or another WIN32OLE dependent cookbook?
# require 'kitchen/config/win32ole_chefspec_linux.rb'

describe 'COOKBOOK_NAME::default' do
  cached(:chef_run) { default_chef_run }
  subject { chef_run }

  before :each do
    stub_command(/.*/).and_return true
    # need to stub out a data bag? see .kitchen.yml too.
    # allow(Chef::EncryptedDataBagItem).to receive(:load).and_return 'stuff'
  end

  describe 'included recipies' do
    it { is_expected.to include_recipe 'my_cookbook::recipe' }
  end
end
