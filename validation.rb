# frozen_string_literal: true

# validation_module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # class_method
  module ClassMethods
    attr_accessor :validations

    def validate(name, validation, *args)
      @validations ||= []
      valid = [validation, name, *args]
      @validations << valid
    end
  end

  # instance_method
  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate!
      self.class.validations.each do |validation|
        instance_var = instance_variable_get("@#{validation[1]}".to_sym)
        send("#{validation[0]}_valid", instance_var, validation[2])
      end
    end

    def presence_valid(value,args)
      raise 'is not present!!!' if value.nil? || value == ''
    end

    def format_valid(value, args)
      raise "#{value} invalid format!!!" if value !~ args
    end

    def type_valid(value, args)
      raise TypeError, "#{value} is not #{args}" unless value.is_a? args
    end
  end
end
