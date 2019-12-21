class Module
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      raise TypeError.new("method name is not symbol") unless method.is_a?(Symbol)

      var_name = "@#{method}"

      define_method(method) { instance_variable_get(var_name) }

      define_method("#{method}=") do |value|
        values = [instance_variable_get(var_name), value].flatten.compact
        instance_variable_set(var_name, values)
      end

      alias_method "#{method}_history", method

      self.class_eval %(
        def #{method}
          @#{method}.last
        end
      )
    end
  end

  def strong_attr_accessor(name, class_name)
    raise TypeError.new("#{name} is not symbol") unless name.kind_of?(Symbol)

    var_name = "@#{name}"

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=") do |value|
      raise TypeError.new("#{name} is not #{class_name}") unless value.kind_of? class_name
      instance_variable_set(var_name, value)
    end
  end
end
