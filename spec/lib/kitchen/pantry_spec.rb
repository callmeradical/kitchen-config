require 'spec_helper'

RSpec.describe Kitchen::Pantry do
  context 'A Valid Kitchen Config' do
    mimic_config = {
      key_id: 'super_secret_key',
      tester_ami: 'ami-666',
      bare_ami: 'ami-999',
      security_group_ids: ['sg-123456']
    }

    cb_name = 'FartBook'
    user = 'Derp'
    os = 'DerpOS'

    let(:subj) { Kitchen::Pantry }
    subject { subj }
    before :each do
      config = File.expand_path(__FILE__)
      ENV['KITCHEN_PANTRY'] = "#{config}/config.yml"
      subj.instance_variable_set('@config', mimic_config)
    end

    describe '#tags' do
      let(:method) { subj.tags(cb_name, user) }
      it { expect(subj).to respond_to(:tags) }
      it { expect(method).to match /Name: \"Chef Tester\"/ }
      it { expect(method).to match /Apps: \"#{cb_name} cookbook test\"/ }
    end

    describe '#load_config' do
      let(:method) { subj.load_config(ENV['KITCHEN_PANTRY']) }
      it { expect(subj).to respond_to(:load_config) }
    end

    describe 'values returned for config' do
      it { expect(subj.tester_ami).to eq('ami-666') }
      it { expect(subj.bare_ami).to eq('ami-999') }
      it { expect(subj.key_id).to eq('super_secret_key') }
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

  context 'An INVALID Kitchen Pantry' do
    let(:subj) { Kitchen::Pantry }
    describe 'if KITCHEN_PANTRY is not valid' do
      it 'it raises an exception' do
        expect { subj.load_config(nil) }.to raise_error /ArguementError/
      end
    end
  end
end
