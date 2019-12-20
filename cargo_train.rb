# frozen_string_literal: true

# rubocop get the f..k out
class CargoTrain < Train
  @train_collection = {}

  def add_carrig(carrig)
    if carrig.instance_of? FreightCarrig
      super
    else
      puts 'Можно присоединить только грузовые вагоны!'
    end
  end
end
