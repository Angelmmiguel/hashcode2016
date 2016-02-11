class Order
  attr_accessor :products

  # Coordinates array [X, Y]
  attr_accessor :destination, :in_progress


  def initialize(destination)
    @destination = destination
    @products = ProductsBag.new
    @in_progress = false
  end
end
