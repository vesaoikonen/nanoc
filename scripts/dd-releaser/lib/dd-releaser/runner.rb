module DDReleaser
  class Runner
    def initialize(io: $stdout, github_repo_name:, version_file:, version_constant:)
      @io = io
      @github_repo_name = github_repo_name
      @version_file = version_file
      @version_constant = version_constant
    end

    def run
      version = read_version
      release_notes = read_release_notes

      validate(version, release_notes)
    end

    private

    ReleaseNotes = Struct.new(:version, :date, :body)

    def read_version
      load(@version_file)
      eval(@version_constant)
    end

    def read_release_notes
      lines = File.readlines('NEWS.md')

      identifier_line = lines.drop(2).first
      body = lines.drop(4).take_while { |l| l !~ /^## / }.join

      regexp = /^## (\d\.\d\.\d) \((\d{4}-\d{2}-\d{2})\)$\n/
      version = identifier_line.sub(regexp, '\1')
      date = identifier_line.sub(regexp, '\2')

      ReleaseNotes.new(version, date, body)
    end

    def validate(version, release_notes)
      unless release_notes.version =~ /\A\d\.\d\.\d\z/
        @io.puts "ERROR: version specified in release notes is malformed"
        exit
      end

      unless release_notes.date =~ /\A\d{4}-\d{2}-\d{2}\z/
        @io.puts "ERROR: date specified in release notes is malformed"
        exit
      end

      unless release_notes.version == version
        @io.puts "ERROR: version specified in release notes is incorrect"
        exit
      end
    end
  end
end
