# coding: utf-8
module Snapper
  class Form
    attr_reader :model

    def initialize(model=nil, args={})
      @model = model
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def valid?
      true
    end

    def do!(what, *args, &blk)
      self.__send__(what, *args, &blk)
    end

    def do(what, *args, &blk)
      if valid?
        do!(what, *args, &blk)
      end
    end

  end
end
