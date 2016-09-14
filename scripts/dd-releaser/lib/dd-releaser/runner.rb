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
      validate_release_notes
    end

    private

    def read_version
      @io.puts '=== Reading version…'
      load(@version_file)
      version = eval(@version_constant)
      @io.puts "Version = #{version}"
      @io.puts

      version
    end

    def validate_release_notes
      puts '=== Validating release notes…'
      unless File.readlines('NEWS.md').drop(2).first =~ / \(\d{4}-\d{2}-\d{2}\)$/
        $stderr.puts 'No proper release date found!'
        exit 1
      end
      puts
    end
  end
end
