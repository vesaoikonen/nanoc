module DDReleaser
  class Runner
    def initialize(io: $stdout, github_repo_name:, version_file:, version_constant:, gem_cmd:)
      @io = io
      @github_repo_name = github_repo_name
      @version_file = version_file
      @version_constant = version_constant
      @gem_cmd = gem_cmd
    end

    def run
      version = read_version

      release_notes = ReleaseNotesReader.new.read
      release_notes.validate_against(version)

      puts '=== Removing old gems…'
      @gem_cmd.remove_old
    rescue DDReleaser::Error => e
      @io.puts "ERROR: #{e.message}"
      exit
    end

    private

    ReleaseNotes = Struct.new(:version, :date, :body)

    def read_version
      load(@version_file)
      eval(@version_constant)
    end
  end
end
