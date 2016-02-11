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

    if quantity > products[type]
      puts "No enough products of type #{type}"
    else
      @products[type] -= quantity
    end
  end
end
