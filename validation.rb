# frozen_string_literal: true

# Validation
class Module
  protected

  def validate(name, valid, *args)
    raise TypeError.new("#{name} or #{valid} is not symbol") unless [name, valid].each { |arg| arg.kind_of?(Symbol) }

    var_name = "@#{name}"

    define_method(:validate!) do
      inst_var = instance_variable_get(var_name)

      if valid == :type
        raise TypeError.new("#{var_name} is not #{args[0]}") unless inst_var.kind_of? args[0]
      end

      raise "#{var_name} is not present" if inst_var.nil? || inst_var == '' if valid == :presence
      raise 'invalid format' if inst_var !~ args[0] if valid == :format
    end

    define_method(:valid?) do
      validate!
      true
    rescue StandardError
      false
    end
  end
end
