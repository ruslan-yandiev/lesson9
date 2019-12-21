# frozen_string_literal: true

# this is a comment
class Train
  include TrainCarrige
  include InstanceCounter # Train.include(InstanceCounter)

  NUMBER_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze
  NAME_FORMAT = /^[а-яa-z]+\D/i.freeze

  attr_reader :carrig, :number
  attr_accessor_with_history :color, :repair_date
  strong_attr_accessor :production_year, Integer
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :name_manufacturer, :format, NAME_FORMAT

  def initialize(number)
    @number = number
    @speed = 0
    @arr_stations = []
    @sum = 0
    @carrig = []
    name_manufacturer!
    validate!
    register_instance
    get!
    show_add_train
  end

  class << self
    def find(number_train)
      puts @train_collection[number_train]
    end

    def get(key, value)
      @train_collection[key] = value
    end
  end

  def each_wagon
    @carrig.each { |carrig| yield(carrig) } if block_given?
  end

  def get!
    self.class.get(@number, self)
  end

  def type_train
    self.class
  end

  def speed=(arg)
    @speed = arg if @speed.positive?
  end

  def show_speed
    puts @speed
  end

  def stop
    @speed = 0
  end

  def show_add_train
    puts "Создан поезд тип: #{self.class} №#{@number},
    \r\nпроизведен #{@name_manufacturer}"
  end

  def show_carriages
    puts self
    each_wagon { |carrig| puts carrig }
  end

  def to_s
    "Поезд тип: #{self.class} №#{@number}, произведен #{@name_manufacturer}
    \r\nприсоединено вагонов: #{@carrig.size}"
  end

  def show_route(arg = nil)
    if arg && @route
      @route.show_way(@train_now)
    elsif @route
      @route.show_way
    end
  end

  def add_carrig(carrig)
    if @speed.zero?
      @carrig << carrig
      carrig.change_status(self)
    else
      puts 'На ходу нельзя цеплять вагоны!'
    end
  end

  def delete_carrig(carrig = nil)
    if @carrig.size.zero?
      puts 'Вагонов уже не осталось.'
    elsif !carrig && @speed.zero?
      disconnect_carrig = @carrig.shift
      disconnect_carrig.change_status(self)
    elsif @speed.zero?
      @carrig.delete(carrig)
      carrig.change_status(self)
    end
  end

  def add_route(route_train)
    @route = route_train
    @route.route.each { |x| @arr_stations << x }
    @arr_stations[0].get_train(self)
    @train_now = @arr_stations[0]
  end

  def go
    if !@route
      puts 'У поезда нет маршрута следования.'
    elsif @sum == @arr_stations.size - 1
      puts 'Поезд находится на конечной станции'
    else
      @sum += 1
      go_train
    end
  end

  def go_back
    if !@route
      puts 'У поезда нет маршрута следования.'
    elsif @sum.zero?
      puts 'Поезд находится на начальной станции'
    else
      @sum -= 1
      go_train
    end
  end

  def show_where
    puts "Поезд находится на станции: #{@train_now.name}" if @route
  end

  protected

  def go_train
    start
    @train_now.send_train(self)
    @arr_stations[@sum].get_train(self)
    @train_now = @arr_stations[@sum]
  end

  def start
    @speed = 100
  end
end
