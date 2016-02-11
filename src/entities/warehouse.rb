class Warehouse
  attr_accessor :location, :id, :products

  def initialize(id, location)
    @id = id
    @location = location
    @products = ProductsBag.new
  end
end
