class Products
  attr_reader :type
  attr_reader :quantity

  def initialize
    @quantity = 0
  end

  def increase
    @quantity += 1
  end
end
