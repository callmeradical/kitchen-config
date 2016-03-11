require 'spec_helper'

RSpec.describe WIN32OLE::Stuby do
  let(:subj) { WIN32OLE::Stuby }
  let(:args) { nil }
  subject { subj }

  before :each do
    allow(WIN32OLE::Stuby).to receive(:ExecQuery).with(args)
  end
  describe '#ExecQuery' do
    it { expect(subj).to respond_to(:ExecQuery).with(args) }
    it { expect(subj).to respond_to(:ExecQuery) }
  end
end

RSpec.describe WIN32OLE::Eachy do
  let(:subj) { WIN32OLE::Eachy }
  subject { subj }

  describe '#each' do
    it { expect(subj).to respond_to :each }
  end
end

RSpec.describe Win32 do
  let(:subj) { Win32 }
  subject { subj }

  describe 'includes WIN32OLE module' do
    it { expect(subj).to include WIN32OLE }
  end
end

RSpec.describe WIN32OLE do
  let(:subj) { WIN32OLE }
  let(:args) { nil }
  subject { subj }

  describe '#connect' do
    it { expect(subj).to respond_to(:connect).with(args) }
  end
end
