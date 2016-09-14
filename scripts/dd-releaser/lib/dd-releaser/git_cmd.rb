module DDReleaser
  class GitCmd
    def self.obtain
      Real.new
    end

    def self.obtain_fake(store)
      Fake.new(store)
    end

    def tag(version)
      raise NotImplementedError
    end

    def push
      raise NotImplementedError
    end

    class Real < GitCmd
      def tag(version)
        system('git', 'tag', '--sign', '--annotate', version, '--message', "Version #{version}")
      end

      def push
        system('git', 'push', 'origin', '--tags')
      end
    end

    class Fake < GitCmd
      def initialize(store)
        @store = store
      end

      def tag(version)
        @store << [:git, :tag, version]
      end

      def push
        @store << [:git, :push]
      end
    end
  end
end
