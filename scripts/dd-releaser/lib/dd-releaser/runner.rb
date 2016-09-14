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
  end
end
