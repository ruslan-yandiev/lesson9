# frozen_string_literal: true

# rubocop get the f..k out
class Station
  include Validation
  include InstanceCounter

  NAME = /^[а-яa-z]+\D/i.freeze

  attr_reader :train, :name
  validate :name, :presence
  validate :name, :format, NAME

  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
    @@all << self
  end

  def self.all
    @@all
  end

  def get_train(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд: #{train.class},  №#{train.number},
    \r\nпроизведенный компанией #{train.name_manufacturer}"
  end

  def show_trains_info
    each_train { |train| puts train }
  end

  def send_train(train)
    puts "Со станции #{name} отправился поезд: #{train.class}  №#{train.number}"
    @trains.delete(train)
  end

  protected

  def each_train
    @trains.each { |train| yield(train) } if block_given?
  end
end
