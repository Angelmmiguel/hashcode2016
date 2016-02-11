class Order
  attr_accessor :products

  # Coordinates array [X, Y]
  attr_accessor :destination

  def initialize
    @products = ProductsBag.new
  end
end
