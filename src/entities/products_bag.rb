module ProductsBag
  attr_reader :products

  def add_products(type, quantity = 1)
    @products[type] ||= Products.new(type)
    @products[type].increase_by quantity
  end
end
