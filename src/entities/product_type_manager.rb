class ProductTypeManager
  @types = []

  def self.load(types)
    @types = types
  end

  def self.weight(type_num)
    @types[type_num].to_i
  end
end
