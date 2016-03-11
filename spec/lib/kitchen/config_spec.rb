require 'spec_helper'

RSpec.describe Kitchen::Config do
  mimic_config = {
    key_id: 'super_secret_key',
    tester_ami: 'ami-666',
    bare_ami: 'ami-999',
    security_group_ids: ['sg-123456']
  }

  cb_name = 'FartBook'
  user = 'Derp'
  os = 'DerpOS'

  let(:subj) { Kitchen::Config }
  subject { subj }
  before :each do
    subj.instance_variable_set('@config', mimic_config)
  end

  describe '#tags' do
    let(:method) { subj.tags(cb_name, user, os) }
    it { expect(subj).to respond_to(:tags) }
    it { expect(method).to match /Name: \"Chef Tester\"/ }
    it { expect(method).to match /Apps: \"#{cb_name} cookbook test\"/ }
  end

  describe 'values returned for config' do
    it { expect(subj.tester_ami).to eq('ami-666') }
    it { expect(subj.bare_ami).to eq('ami-999') }
    it { expect(subj.key_id).to eq('super_secret_key') }
  end

  describe 'deprecated methods' do
    it 'presents a warning to the user' do
      expect(Kernel).to receive(:warn)
      subj.security_group_ids_yml
    end
    it 'calls the new method for the user' do
      expect(subj).to receive(:security_group_ids)
      subj.security_group_ids_yml
    end
  end

  describe 'if key is not present in config' do
    it 'raises an exception' do
      expect { subj.foo }.to raise_error /Undefined method/
    end
    it 'presents the user with available keys' do
      expect { subj.bar }.to raise_error /:key_id, :tester_ami, :bare_ami/
    end
  end
end
