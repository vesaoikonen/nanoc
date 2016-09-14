describe DDReleaser::Executor do
  subject(:cmd) { described_class.obtain_fake(store) }
  let(:store) { [] }

  describe '#exec' do
    subject { cmd.exec('a', 'b') }

    it 'records' do
      subject
      expect(store).to eql([['a', 'b']])
    end
  end
end
