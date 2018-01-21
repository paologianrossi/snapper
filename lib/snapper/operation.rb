require 'ostruct'

module Snapper
  class Operation

    attr_reader :result

    def initialize(*args)
      @result = Result.new
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
      def initialize(outcome=true)
        super()
        @outcome = !! outcome
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
    end
  end
end
