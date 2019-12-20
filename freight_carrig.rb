# frozen_string_literal: true

# rubocop get the f..k out
class FreightCarrig < Carrig
  def to_s
    super + "грузоподъемность: #{@amount},
    \r\nзагружен на #{@amount_now}кг., недогруз #{free_amount}кг."
  end
end
