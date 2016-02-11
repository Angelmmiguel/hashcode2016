class Drone

  attr_reader :location, :busy

  def initialize(location)
    @products = ProductsBag.new
    @location = location
    @busy = 0
  end

  def busy?
    @busy > 0
  end

  def next_turn
    @busy -= 1 if @busy != 0
  end

  def move(destination)
    result = Math.sqrt(Math.abs(location[0] - destination[0])**2 +
                       Math.abs(location[1] - destination[1])**2).ceil
    @busy += result
    # Return number of turns
    self
  end

  def load(warehouse, type, quantity)
    if location == warehouse.location
      warehouse.products.remove(type, quantity)
      products.add(type, quantity)
      @busy += 1
    else
      puts 'ERROR DRONE is not at the position of WAREHOUSE'
    end
    self
  end

  def deliver(destination, type, quantity)
    if location == destination
      @busy += 1
      products.remove(type, quantity)
      1
    else
      puts 'ERROR DRONE is not at the position of the client'
    end
    self
  end
end
