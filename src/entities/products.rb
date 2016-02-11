class Products
  attr_reader :type
  attr_reader :quantity

  def initialize(type)
    @type = type
    @quantity = 0
  end

  def increase_by(quantity)
    @quantity += quantity
  end

  def decrease_by(quantity)
    @quantity -= quantity
  end

  def to_s
    "Products: Type #{type} Quantity #{quantity}"
  end
end
