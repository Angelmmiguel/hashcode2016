class Order
  attr_reader :products, :destination

  def initialize
    @products = []
  end

  def add_product(type_num)
    @products[type_num] ||= Products.new()
    @products[type_num].increase
  end
end
