module DDReleaser
  class Executor
    def self.obtain
      Real.new
    end

    def self.obtain_fake(store)
      Fake.new(store)
    end

    def exec(*args)
      raise NotImplementedError
    end

    class Real < Executor
      def exec(*args)
        system(*args)
      end
    end

    class Fake < Executor
      def initialize(store)
        @store = store
      end

      def exec(*args)
        @store << args
      end
    end
  end
end
