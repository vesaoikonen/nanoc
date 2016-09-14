describe DDReleaser::GitCmd do
  subject(:cmd) { described_class.obtain_fake(store) }
  let(:store) { [] }

  describe '#tag' do
    subject { cmd.tag('1.0.0') }

    it 'records' do
      subject
      expect(store).to eql([[:git, :tag, '1.0.0']])
    end
  end

  describe '#push' do
    subject { cmd.push }

    it 'records' do
      subject
      expect(store).to eql([[:git, :push]])
    end
  end
end
