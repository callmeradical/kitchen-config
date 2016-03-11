require 'spec_helper'

RSpec.describe Win32::Registry::Regmock do
  # create a copy of class
  let(:subj) { Win32::Registry::Regmock }
  # this is required to ref unit tests directly (is_expected)

  describe '#open' do
    it { expect(subj).to respond_to(:open) }
    it { expect(subj.open).to eq(true) }
  end
end

RSpec.describe Win32::Registry do
  let(:subj) { Win32::Registry }
  let(:kaa) { Win32::Registry::KEY_ALL_ACCESS }
  regmocks = {
    'HKEY_LOCAL_MACHINE' => Win32::Registry::HKEY_LOCAL_MACHINE,
    'HKEY_USERS'         => Win32::Registry::HKEY_USERS,
    'HKEY_CURRENT_USER'  => Win32::Registry::HKEY_CURRENT_USER
  }

  regmocks.each do |k, v|
    describe "has #{k}" do
      it { expect(v).to eq Win32::Registry::Regmock }
      it { expect(v).to respond_to(:open) }
      it { expect(v.open).to eq(true) }
    end
  end

  describe 'has KEY_ALL_ACCESS' do
    it { expect(kaa).to eq 0x000000 }
  end

  describe '#get_value' do
    it { expect(subj).to respond_to(:get_value) }
    it { expect(subj.get_value).to match /super/ }
  end
end
