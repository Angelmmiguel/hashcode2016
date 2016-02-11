class Products
  attr_reader :type
  attr_reader :quantity

  def initialize
    @quantity = 0
  end

  def increase_by(quantity)
    @quantity += quantity
  end
end
