# frozen_string_literal: true

# this is comments
class Carrig
  include Validation
  include TrainCarrige

  NUMBER_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze
  NAME_FORMAT = /^[а-яa-z]+\D/i.freeze

  attr_reader :number, :amount
  attr_accessor_with_history :color, :repair_date
  strong_attr_accessor :production_year, Integer

  def initialize(number, amount)
    @number = number
    @amount = amount
    @amount_now = 0
    @status = false
    name_manufacturer!
    validate!
  end

  def increase_amount(amount)
    if @amount_now + amount >  @amount
      puts 'Недостаточно места в вагоне!!!'
    elsif amount <= @amount
      @amount_now += amount
      free_amount
    else
      puts "Вагон может вместить только #{@amount} !!!"
    end
  end

  def free_amount
    @amount - @amount_now
  end

  def show_amount_now
    @amount_now
  end

  def show_free_amount
    free_amount
  end

  def change_status(train)
    if train.carrig.include?(self)
      connect
    else
      disconnect
    end
  end

  def connect
    @status = true
  end

  def disconnect
    @status = false
  end

  def to_s
    "Тип вагона: #{self.class}, номер: #{number}, соединен ли с поездом: #{@status}, производитель #{name_manufacturer}"
  end

  protected :connect, :disconnect
end
