module DDReleaser
  class GitCmd
    def initialize(executor)
      @executor = executor
    end

    def tag(version)
      @executor.exec('git', 'tag', '--sign', '--annotate', version, '--message', "Version #{version}")
    end

    def push
      @executor.exec('git', 'push', 'origin', '--tags')
    end
  end
end
