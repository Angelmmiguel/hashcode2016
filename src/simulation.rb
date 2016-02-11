require_relative 'entities/product_type_manager'
require_relative 'entities/products_bag'
require_relative 'entities/order'
require_relative 'entities/drone'
require_relative 'entities/warehouse'
require 'pry'

@products = []
@warehouses = []
@orders = []
@map = {}

def parse_file
  # Read File
  file = File.read('datasets/busy_day.in')

  # Get Lines
  lines = file.split("\n")

  # Get Headers
  headers = lines.shift.split(' ')

  # Get Map
  %w(rows columns drones turns max_payload).each_with_index do |el, index|
    @map[el.to_sym] = headers[index].to_i
  end

  # Ignore number of products
  lines.shift

  # Get products
  @products = lines.shift.split(' ')

  # Get warehouses
  lines.shift.to_i.times do
    positions = lines.shift.split(' ')
    number_of_products = lines.shift.split(' ')
    @warehouses << {
      row: positions.first,
      col: positions.last,
      n_products: number_of_products
    }
  end

  # Get orders
  lines.shift.to_i.times do
    positions = lines.shift.split(' ')
    # Ignore line
    lines.shift
    products_types = lines.shift.split(' ')
    @orders << {
      row: positions.first,
      col: positions.last,
      products_types: products_types
    }
  end
end

def build_warehouses
  warehouses = []
  @warehouses.each do |wh|
    new_wh = Warehouse.new([wh[:row], wh[:col]])
    wh[:n_products].each_with_index do |n, i|
      new_wh.products.add(i, n.to_i)
    end
    warehouses << new_wh
  end
  warehouses
end

def build_orders
  orders = []
  @orders.each do |order|
    new_order = Order.new([order[:row], order[:col]])
    order[:products_types].each do |n|
      new_order.products.add(n.to_i)
    end
    orders << new_order
  end
  orders
end

# parse file and fill @products, @warehouses, @orders and @map
parse_file

#
ProductTypeManager.load(@products)

orders = build_orders
warehouses = build_warehouses
drones = []
turns = @map[:turns]
steps = []

@map[:drones].times { |_| drones << Drone.new(warehouses.first.location) }

# Main bucle
while turns > 0
  free_drones = drones.select { |drone| !drone.busy? }

  unless free_drones.empty?
    # Start the turn
    orders.each do |order|
      next if order.in_progress
      # Order must be in progress
      
    end
  end

  # Update turn
  drones.each(&:next_turn)
  turns -= 1
end
