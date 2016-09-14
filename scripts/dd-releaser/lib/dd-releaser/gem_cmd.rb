module DDReleaser
  class GemCmd
    def self.obtain
      Real.new
    end

    def self.obtain_fake(store)
      Fake.new(store)
    end

    def build(gem_file_name)
      raise NotImplementedError
    end

    def push(gem_file_name)
      raise NotImplementedError
    end

    class Real < GemCmd
      def build(gem_file_name)
        system('gem', 'build', gem_file_name)
      end

      def push(gem_file_name)
        system('gem', 'push', gem_file_name)
      end
    end

    class Fake < GemCmd
      def initialize(store)
        @store = store
      end

      def build(gem_file_name)
        @store << [:gem, :build, gem_file_name]
      end

      def push(gem_file_name)
        @store << [:gem, :push, gem_file_name]
      end
    end
  end
end
