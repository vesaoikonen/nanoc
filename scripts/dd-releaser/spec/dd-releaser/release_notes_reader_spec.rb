describe DDReleaser::ReleaseNotesReader do
  subject(:reader) { described_class.new.read }

  it 'reads the correct release notes' do
    expect(subject.version).to eql('0.0.1')
    expect(subject.date).to eql('2016-09-31')
    expect(subject.body).to eql("Stuff here.\n")
  end
end
