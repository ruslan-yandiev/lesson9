# frozen_string_literal: true

# validation_module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # class_method
  module ClassMethods
    def validate(name, validation, *args)
      send "#{validation}_valid", name, *args
    end

    protected

    def presence_valid(name)
      define_method("#{name}_present?") do
        value = instance_variable_get("@#{name}")
        raise "#{name} is not present!!!" if value.nil? || value == ''
      end
    end

    def format_valid(name, args)
      define_method("#{name}_format?") do
        value = instance_variable_get("@#{name}")
        raise "#{name} invalid format!!!" if value !~ args
      end
    end

    def type_valid(name, args)
      define_method("#{name}_type?") do
        value = instance_variable_get("@#{name}")
        raise TypeError, "#{name} is not #{args}" unless value.is_a? args
      end
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

    protected

    def validate!
      my_methods = public_methods.grep(/present|format|type/)
      my_methods.each { |method| send method }
    end
  end
end
