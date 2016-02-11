class Order
  # Array of Products objects
  # The position in the array is the product type
  attr_reader :products

  # Coordinates array [X, Y]
  attr_accessor :destination

  def initialize
    @products = []
  end

  def add_product(type)
    @products[type] ||= Products.new()
    @products[type].increase_by 1
  end
end
