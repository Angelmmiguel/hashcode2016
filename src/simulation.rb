require_relative 'entities/product_type_manager'
require_relative 'entities/products_bag'
require_relative 'entities/order'
require_relative 'entities/drone'
require_relative 'entities/warehouse'
require_relative 'entities/output'
require 'pry'

if ARGV.count != 2
  puts 'usage: simulation.rb [file] [initial seed]'
  exit
end

@products = []
@warehouses = []
@orders = []
@map = {}

def parse_file
  # Read File
  file = File.read(ARGV[0])

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
  @warehouses.each_with_index do |wh, i|
    new_wh = Warehouse.new(i, [wh[:row].to_i, wh[:col].to_i])
    wh[:n_products].each_with_index do |n, i|
      new_wh.products.add(i, n.to_i)
    end
    warehouses << new_wh
  end
  warehouses
end

def build_orders
  orders = []
  @orders.each_with_index do |order, i|
    new_order = Order.new(i, [order[:row].to_i, order[:col].to_i])
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

@map[:drones].times do |x|
  drones << Drone.new(x, warehouses.first.location, @map[:max_payload])
end

1.times do |i|
  seed = i + ARGV[1].to_i
  orders = orders.shuffle(random: Random.new(seed))

  # Main bucle
  while turns > 0
    free_drones = drones.select { |drone| !drone.busy? }

    unless free_drones.empty?
      # Start the turn
      orders.each do |order|
        next if order.in_progress
        # Order must be in progress
        my_drone = free_drones.shift
        my_drone.schedule_order(order, warehouses) unless my_drone.nil?
      end
    end

    # Update turn
    drones.each(&:next_turn)
    turns -= 1
    puts "Turns #{turns} / #{@map[:turns]}"
  end

  Output.bulk_file("./solutions/#{ARGV[0]}-#{seed}")
end
