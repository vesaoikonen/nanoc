module DDReleaser
  class GemCmd
    def initialize(executor)
      @executor = executor
    end

    def build(gem_file_name)
      @executor.exec('gem', 'build', gem_file_name)
    end

    def push(gem_file_name)
      @executor.exec('gem', 'push', gem_file_name)
    end
  end
end
