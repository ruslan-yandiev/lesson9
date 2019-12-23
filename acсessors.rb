# frozen_string_literal: true

# add getter, satter and alias_method
class Module
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      raise TypeError, 'method name is not symbol' unless method.is_a?(Symbol)

      var_name = "@#{method}"

      define_method(method) { instance_variable_get(var_name) }

      define_method("#{method}=") do |value|
        values = [instance_variable_get(var_name), value].flatten.compact
        instance_variable_set(var_name, values)
      end

      define_method("#{method}_history") do
        value = instance_variable_get(var_name)
        instance_variable_set("@#{method}_history".to_sym, value)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    raise TypeError, "#{name} is not symbol" unless name.is_a?(Symbol)

    var_name = "@#{name}"

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=") do |value|
      raise TypeError, "#{name} is not #{class_name}" unless value.is_a? class_name

      instance_variable_set(var_name, value)
    end
  end
end
