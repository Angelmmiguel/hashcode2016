class Drone
  include ProductsBag

  attr_reader :location, :destination

  def initialize
    @products = []
  end
end
