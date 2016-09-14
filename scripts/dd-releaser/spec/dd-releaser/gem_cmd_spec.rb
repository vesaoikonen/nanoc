describe DDReleaser::GemCmd do
  subject(:cmd) { described_class.new(executor) }
  let(:executor) { DDReleaser::Executor.obtain_fake(store) }
  let(:store) { [] }

  describe '#build' do
    subject { cmd.build('abc-1.0.0.gemspec') }

    it 'records' do
      subject
      expect(store).to eql([['gem', 'build', 'abc-1.0.0.gemspec']])
    end
  end

  describe '#push' do
    subject { cmd.push('abc-1.0.0.gemspec') }

    it 'records' do
      subject
      expect(store).to eql([['gem', 'push', 'abc-1.0.0.gemspec']])
    end
  end
end
