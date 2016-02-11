class Drone
  include ProductsBag

  attr_reader :location, :destination

  def initialize
    @products = ProductsBag.new
  end

  def load(warehouse, type, quantity)
    puts 'ERROR 1' unless location == warehouse.location
  end

  def deliver
  end
end
