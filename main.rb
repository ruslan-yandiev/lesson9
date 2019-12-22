# frozen_string_literal: true

require_relative 'validation'
require_relative 'acсessors'
require_relative 'module_manufacturer'
require_relative 'instance_counter'
require_relative 'carrig'
require_relative 'freight_carrig'
require_relative 'passenger_carrig'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'route'
require_relative 'snake_case'

arr = [
  '- Создавать станции',
  '- Создавать поезда',
  '- Создавать маршруты и управлять станциями в нем (добавлять, удалять)',
  '- Назначать маршрут поезду',
  '- Добавлять вагоны к поезду',
  '- Отцеплять вагоны от поезда',
  '- Перемещать поезд по маршруту вперед и назад',
  '- Просматривать список станций и список поездов на станции'
]

puts 'Программа позволит:'
arr.each { |x| puts x }
puts
choices = Constr.new

loop do
  choices.collection.each_with_index do |type, index|
    puts "\t#{index}. create: #{type}s"
  end
  puts
  print 'Выберите номер действия: '
  number = gets.chomp.to_i

  print 'Сколько обхектов создать: '
  amount = gets.chomp.to_i

  choices.constructor(number, amount)
  break if choices.collection.empty?
end

choices.start
