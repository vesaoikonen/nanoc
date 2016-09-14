module DDReleaser
  class ReleaseNotesReader
    def read
      lines = File.readlines('NEWS.md')

      identifier_line = lines.drop(2).first
      body = lines.drop(4).take_while { |l| l !~ /^## / }.join

      regexp = /^## ([^ ]+) \(([^(]+)\)$\n/
      version = identifier_line.sub(regexp, '\1')
      date = identifier_line.sub(regexp, '\2')

      ReleaseNotes.new(version: version, date: date, body: body)
    end
  end
end
