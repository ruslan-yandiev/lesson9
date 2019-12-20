# frozen_string_literal: true

# rubocop get the f..k out
module InstanceCounter
  def self.included(arg_class)
    arg_class.extend ClassMethods
    arg_class.send :include, InstanceMethods
  end

  # rubocop get the f..k out
  module ClassMethods
    attr_reader :instances

    def plus
      @instances ||= 0
      @instances += 1
    end
  end

  # rubocop get the f..k out
  module InstanceMethods
    protected

    def register_instance
      self.class.plus
    end
  end
end
