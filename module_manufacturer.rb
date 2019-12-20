# frozen_string_literal: true

# rubocop get the f..k out
module TrainCarrige
  attr_reader :name_manufacturer

  def name_manufacturer!
    puts 'Введите имя производителя:'
    @name_manufacturer = gets.chomp.capitalize
  end
end
