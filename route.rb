# frozen_string_literal: true

# rubocop get the f..k out
class Route
  include InstanceCounter

  attr_accessor :route, :name

  NAME = /^[а-яa-z]+\D/i.freeze

  def initialize(name)
    @name = name
    @route = []
    validate!
    register_instance
  end

  # !!validate!
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_stations(new_route)
    @route << new_route
  end

  def delete_way(index)
    @route.delete_at(index)
  end

  def show_way(name_station = nil)
    if name_station
      num = @route.index(name_station)
      puts "Вы покинули станцию #{@route[num - 1].name},
      \r\nСейчас находитесь на станции #{@route[num].name}
      \r\nСледующая остановка #{@route[num + 1].name}"
    else
      @route.each { |x| puts x.name }
    end
  end

  protected

  def validate!
    raise 'Name can`t be nil' unless @name
    raise 'Name can`t be empty string' if @name == ''
    raise 'Name has invalid format' if @name !~ NAME
  end
end
