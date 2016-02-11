class Warehouse
  include ProductsBag

  # [X, Y] array
  attr_accessor :location

  def initialize(location)
    @location = location
    @products = []
  end
end
