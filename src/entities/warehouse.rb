class Warehouse
  attr_accessor :products

  # [X, Y] array
  attr_accessor :location

  def initialize(location)
    @location = location
    @products = ProductsBag.new
  end
end
