class ProductsBag
  attr_reader :products

  def initialize
    @products = {}
  end

  def add(type, quantity = 1)
    @products[type] ||= 0
    @products[type] += quantity
  end

  def remove(type, quantity = 1)
    @products[type] ||= 0
    @products[type] += quantity
  end
end
