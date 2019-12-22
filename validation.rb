# frozen_string_literal: true

# Validation
class Module
  protected

  def validate(name, valid, *args)
    raise TypeError, "#{name} or #{valid} is not symbol" unless [name, valid].each { |arg| arg.is_a?(Symbol) }

    var_name = "@#{name}"

    if valid == :presence
      define_method("#{name}_vp".to_sym) do
        inst_var = instance_variable_get(var_name)
        raise "#{var_name} is not present" if inst_var.nil? || inst_var == ''
      end
    end

    if valid == :type
      define_method("#{name}_v".to_sym) do
        inst_var = instance_variable_get(var_name)
        raise TypeError, "#{var_name} is not #{args[0]}" unless inst_var.is_a? args[0]
      end
    end

    if valid == :format && args[0] == /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze
      define_method("#{name}_v".to_sym) do
        inst_var = instance_variable_get(var_name)
        raise "invalid format #{inst_var}" if inst_var !~ args[0]
      end
    end

    if valid == :format && args[0] == /^[а-яa-z]+\D/i.freeze
      define_method("#{name}_v".to_sym) do
        inst_var = instance_variable_get(var_name)
        raise "invalid format #{inst_var}" if inst_var !~ args[0]
      end
    end

    define_method(:validate!) do
      my_methods = public_methods.grep(/name_v|number_v|name_manufacturer_v/)
      my_methods.each { |method| send method }
    end

    define_method(:valid?) do
      validate!
      true
    rescue StandardError
      false
    end
  end
end
