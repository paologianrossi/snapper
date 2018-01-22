# coding: utf-8

require "dry-validation"

module Snapper
  class Form
    attr_reader :model
    attr_reader :errors

    def initialize(model)
      @model = model
      @errors = []
    end

    def self.field(field_name)
      (@fields ||= []) << field_name
      attr_accessor field_name
    end

    def self.fields
      @fields ||= []
    end

    def fields
      Hash[
        self.class.fields.map do |name|
          [name, self.send(name)]
        end
      ]
    end

    def self.validation(&blk)
      @schema = Dry::Validation.Schema(&blk)
    end

    def validate(params)
      return true unless @schema
      result = @schema.(params)
      @errors = result.errors
      result.success?
    end

  end
end
