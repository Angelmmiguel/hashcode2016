class Drone
  attr_reader :location, :busy

  def initialize(location, max_weight)
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

  def move(destination)
    result = Math.sqrt(Math.abs(location[0] - destination[0])**2 +
                       Math.abs(location[1] - destination[1])**2).ceil
    @busy += result
    # Return number of turns
    self
  end

  def load(warehouse, type, quantity)
    if location == warehouse.location
      warehouse.products.remove(type, quantity)
      products.add(type, quantity)
      @busy += 1
    else
      puts 'ERROR DRONE is not at the position of WAREHOUSE'
    end
    self
  end

  def deliver(destination, type, quantity)
    if location == destination
      @busy += 1
      products.remove(type, quantity)
      1
    else
      puts 'ERROR DRONE is not at the position of the client'
    end
    self
  end

  def distance_to(destination)
    Math.sqrt(Math.abs(location[0] - destination[0])**2 +
              Math.abs(location[1] - destination[1])**2).ceil
  end

  def weight_current
    @products.products.map do |p|
      if p.nil?
        0
      else
        ProductTypeManager.weight(p)
      end
    end
  end

  def weight_available
    @max_weight - weight_current
  end

  def schedule_order(order, warehouses)
    started_location = location

    order.products.products.each_with_index do |quantity, type|
      next if quantity.nil? || quantity == 0

      if ProductTypeManager.weight(type) > weight_available
        @products.products.each_with_index do |quantity, type|
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

    @products.products.each_with_index do |quantity, type|
      deliver(order, type, quantity)
    end
  end
end
