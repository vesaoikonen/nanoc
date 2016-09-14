describe DDReleaser::ReleaseNotes do
  subject(:release_notes) { described_class.new(version: version, date: date, body: body) }

  let(:version) { '0.0.1' }
  let(:date) { '2019-02-13' }
  let(:body) { 'stuff here' }

  describe '#validate_against' do
    subject { release_notes.validate_against(release_version) }

    let(:release_version) { '0.0.1' }

    context 'everything correct' do
      it 'passes' do
        subject
      end
    end

    context 'mismatching version' do
      let(:release_version) { '0.0.2' }

      it 'errors' do
        expect { subject }.to raise_error(DDReleaser::Error)
      end
    end

    context 'malformed version' do
      let(:version) { '0.0.1a' }

      it 'errors' do
        expect { subject }.to raise_error(DDReleaser::Error)
      end
    end

    context 'malformed date' do
      let(:date) { '2019-2-13' }

      it 'errors' do
        expect { subject }.to raise_error(DDReleaser::Error)
      end
    end
  end
end
