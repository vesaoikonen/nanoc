describe DDReleaser::Executor do
  subject(:cmd) { described_class.obtain_fake(store) }
  let(:store) { [] }

  describe '#exec' do
    subject { cmd.exec('a', 'b') }

    it 'records' do
      subject
      expect(store).to eql([[:system, 'a', 'b']])
    end
  end

  describe '#rm' do
    subject { cmd.rm('a.txt') }

    it 'records' do
      subject
      expect(store).to eql([[:rm, 'a.txt']])
    end
  end
end
