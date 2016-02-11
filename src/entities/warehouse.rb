class Warehouse
  # Array of products
  attr_reader :products

  # [X, Y] array
  attr_accessor :location

  def initialize(location)
    @location = location
    @products = []
  end

  def add_products(type, quantity)
    @products[type] ||= Products.new()
    @products[type].increase_by quantity
  end
end
