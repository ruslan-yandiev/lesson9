# frozen_string_literal: true

# rubocop get the f..k out
class PassengerCarrig < Carrig
  def increase_amount
    super(1)
  end

  def to_s
    super + "вместимость: #{@amount}
    \r\nчеловек, зянято #{@amount_now} мест, свободно мест: #{free_amount}"
  end
end
