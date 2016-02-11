class Drone
  include ProductsBag

  attr_reader :location

  def initialize
    @products = ProductsBag.new
  end

  def move(destination)
    Math.sqrt(Math.abs(location[0] - destination[0])**2 +
              Math.abs(location[1] - destination[1])**2).ceil
  end

  def load(warehouse, type, quantity)
    if location == warehouse.location
      warehouse.products.remove(type, quantity)
      products.add(type, quantity)
      1
    else
      puts 'ERROR DRONE is not at the position of WAREHOUSE'
    end
  end

  def deliver(destination, type, quantity)
    if location == destination
      products.remove(type, quantity)
      1
    else
      puts 'ERROR DRONE is not at the position of the client'
    end
  end
end
