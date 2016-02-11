class Warehouse
  # [X, Y] array
  attr_reader :location

  # Array of products
  attr_reader :products

  def initialize(location)
    @location = location
  end
end
