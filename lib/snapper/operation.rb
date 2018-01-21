require 'ostruct'

module Snapper
  class Operation

    attr_reader :result

    def initialize(*args)
      @result = Result.new(on_success: self.method(:on_success),
                           on_failure: self.method(:on_failure))
      params(*args)
    end

    def params(*)
      nil
    end

    def self.call(*args, &blk)
      self.new(*args).call(&blk)
    end

    def call
      result.fail! unless process
      if block_given? && result.success?
        yield(result)
      end
      result
    end

    def on_success(*args)
    end

    def on_failure(*args)
    end

    def output(key, value=nil)
      if block_given?
        result[key] = yield(key, value)
      else
        result[key] = value
      end
    end

    def process
      raise NotImplementedError
    end

    class Result < OpenStruct
      def initialize(outcome=true, on_success: nil, on_failure: nil)
        super()
        @outcome = !! outcome
        @on_success = on_success
        @on_failure = on_failure
      end

      def fail!
        @outcome = false
      end

      def failure?
        ! success?
      end

      def success?
        @outcome
      end

      def on_success(&blk)
        @on_success = blk if blk
        @on_success
      end

      def on_failure(&blk)
        @on_failure = blk if blk
        @on_failure
      end

      def call(*args)
        if success?
          @on_success.call(*args)
        else
          @on_failure.call(*args)
        end
      end
    end
  end
end
