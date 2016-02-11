class Drone

  attr_reader :location, :busy, :id

  def initialize(ind, location)
    @id = id
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

  def load(warehouse, type, quantity)
    move(warehouse.location)
    warehouse.products.remove(type, quantity)
    products.add(type, quantity)
    @busy += 1
    Output.add_command("#{@id} L #{warehouse.id} #{type} #{quantity}")
    self
  end

  def deliver(order, type, quantity)
    move(order.destination)
    @busy += 1
    products.remove(type, quantity)
    Output.add_command("#{@id} D #{order.id} #{type} #{quantity}")
    self
  end

  private

  def move(destination)
    result = Math.sqrt(Math.abs(location[0] - destination[0])**2 +
                       Math.abs(location[1] - destination[1])**2).ceil
    @busy += result
  end
end
