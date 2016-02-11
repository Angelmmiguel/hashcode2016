class Order
  # Coordinates array [X, Y]
  attr_accessor :destination, :in_progress, :id, :products

  def initialize(id, destination)
    @destination = destination
    @products = ProductsBag.new
    @in_progress = false
    @id = id
  end
end
