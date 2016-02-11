class Drone
  attr_reader :location, :busy, :id

  def initialize(id, location, max_weight)
    @id = id
    @products = ProductsBag.new
    @location = location
    @busy = 0
    @max_weight = max_weight
  end

  def busy?
    @busy > 0
  end

  def next_turn
    @busy -= 1 if @busy != 0
  end

  def load(warehouse, type, quantity)
    move(warehouse.location)
    warehouse.products.remove(type, quantity)
    @products.add(type, quantity)
    @busy += 1
    Output.add_command("#{@id} L #{warehouse.id} #{type} #{quantity}")
    self
  end

  def deliver(order, type, quantity)
    move(order.destination)
    @busy += 1
    @products.remove(type, quantity)
    Output.add_command("#{@id} D #{order.id} #{type} #{quantity}")
    self
  end

  def schedule_order(order, warehouses)
    started_location = location

    order.products.products.each do |type, quantity|
      next if quantity.nil? || quantity == 0

      if ProductTypeManager.weight(type) > weight_available
        @products.products.each do |type, quantity|
          next if quantity == 0
          deliver(order, type, quantity)
        end
      end

      warehouse_with_product = warehouses.select do |w|
        # TODO: ALOMEJOR SE NECESITAN MAS DE UNO
        w.products.products[type] >= quantity
      end

      min_warehouse = warehouse_with_product.min_by do |w|
        distance_to w.location
      end

      if min_warehouse.nil?
        @location = started_location
        @busy = 0
      else
        load(min_warehouse, type, quantity)
      end
    end

    @products.products.each do |type, quantity|
      next if quantity == 0
      deliver(order, type, quantity)
    end
  end

  private

  def move(destination)
    @busy += distance_to(destination)
  end

  def distance_to(destination)
    Math.sqrt((location[0] - destination[0]).abs**2 +
              (location[1] - destination[1]).abs**2).ceil
  end

  def weight_current
    (@products.products.map do |type, quantity|
      ProductTypeManager.weight(type) * quantity
    end).max || 0
  end

  def weight_available
    @max_weight - weight_current
  end
end
