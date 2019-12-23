# frozen_string_literal: true

# rubocop get the f..k out
class FreightCarrig < Carrig
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :name_manufacturer, :format, NAME_FORMAT

  def to_s
    super + "грузоподъемность: #{@amount},
    \r\nзагружен на #{@amount_now}кг., недогруз #{free_amount}кг."
  end
end
