class ParkingLot
  def initialize(number_of_levels)
    @parking_levels = []
    number_of_levels.times do 
      @parking_levels.push ParkingLotLevel.new
    end
  end

  def number_of_levels
    @parking_levels.length
  end

  def add_parking_spot_to_level(level_number, parking_spot_size)
    @parking_levels[level_number].add_parking_spot(parking_spot_size)
  end

  def parking_spot_exists?(size)
    find_parking_spot_by_size(size) ? true : false
  end

  def find_parking_spot_by_size(size)
    @parking_levels.each do |parking_level|
      parking_spot = parking_level.find_parking_spot(size)
      return parking_spot if !parking_spot.nil?
    end
    nil
  end

  def find_parking_spot(car)
    find_parking_spot_by_size(car.size)
  end

  def add_car_to_parking_spot(car, parking_spot)
    parking_spot.park_car(car)
  end

  def print
    @parking_levels.each do |parking_level|
      parking_level.print
    end
  end

  def find_optimal_multicar_combination(cars)
    if parking_spot_exists? 50
      return calculate_optimal_multicar(cars)
    else
      return nil
    end
  end

  private

  def calculate_optimal_multicar(cars, max_size=50)
    car_combos = []
    cars.length.times do |i|
      car_combos += cars.combination(i).to_a
    end
    valid_car_combos = car_combos.select do |combo|
      net_car_sizes = combo.reduce(0) do |sum, car|
        car.size + sum
      end
      net_car_sizes <= 50
    end
    
    max_profit = 0
    optimal_car_combo = []
    valid_car_combos.each do |car_combo|
      profit = car_combo.reduce(0) do |sum, car|
        car.parking_cost + sum
      end
      if profit > max_profit
        max_profit = profit
        optimal_car_combo = car_combo
      end
    end
    return optimal_car_combo
  end
end

class ParkingLotLevel
  def initialize
    @parking_spots = []
  end

  def add_parking_spot(size)
    @parking_spots.push(ParkingSpot.new(size))
  end

  def find_parking_spot(size)
    @parking_spots.each do |parking_spot|
      return parking_spot if parking_spot.size >= size && !parking_spot.occupied?
    end
    nil
  end

  def print
    level = ""
    @parking_spots.each do |parking_spot|
      if parking_spot.occupied?
        level << "X "
      else
        level << "#{parking_spot.size} "
      end
    end
    puts level
  end
end

class ParkingSpot
  SIZES = [10, 15, 20, 25, 30, 35, 40, 45, 50].freeze
  def initialize(size)
    @size = size
    @occupied = false
    @current_car = nil
  end
  
  def size
    @size
  end

  def occupied?
    @occupied
  end

  def park_car(car)
    @occupied = true
    @current_car = car
  end

  def remove_car
    @current_car = nil
    @occupied = false
  end

  def current_car
    @current_car
  end
end

class Car
  BRANDS = ["Dodge", "Jaguar", "Mercedes", "Audi"].freeze
  BRAND_PARKING_COST = {"Dodge" => 50, "Jaguar" => 170, "Mercedes" => 100, "Audi" => 30}
  DEFAULT_PARKING_COST = 10
  def initialize(size, brand=nil)
    raise "invalid size" if size <= 0
    @size = size
    @brand = brand || BRANDS.sample
    @parking_cost = BRAND_PARKING_COST[@brand] || DEFAULT_PARKING_COST
  end

  def parking_cost
    @parking_cost
  end

  def size
    @size
  end
end



# Command Line program
if $PROGRAM_NAME == __FILE__
  def seed_random_data(parking_lot)
    parking_lot.number_of_levels.times do |level_number|
      random_parking_spot_sizes = []
      5.times do
        random_parking_spot_sizes.push(ParkingSpot::SIZES.sample)
      end
      random_parking_spot_sizes.each do |parking_spot_size|
        parking_lot.add_parking_spot_to_level(level_number, parking_spot_size)
      end
    end
  end
  number_of_levels = ARGV[0] ? ARGV[0].to_i : 4
  parking_lot = ParkingLot.new(number_of_levels)

  seed_random_data(parking_lot)

  puts "Parking Lot:"
  parking_lot.print
  puts "------------------"

  while(true)
    puts "Input the size of the car you would like to park,\n\tOR\n\t'm' for multicar parking,\n\t'p' to see available parking spots,\n\t'q' to quit:"
    car_size = $stdin.gets.chomp
    if car_size == 'q'
      break
    elsif car_size == 'p'
      parking_lot.print
    elsif car_size == 'm'
      puts "type in each car size and brand, as SIZE BRAND, followed by the 'Enter' key\n\t(e.g. '15 Dodge', or '45 Jaguar').\ntype in 'stop' to stop adding cars"
      cars = []
      while(true)
        car_info = $stdin.gets.chomp
        if car_info == 'stop'
          optimal_car_combo = parking_lot.find_optimal_multicar_combination(cars)
          if optimal_car_combo.length > 0
            puts "optimal profit value is: $#{optimal_car_combo.reduce(0){|profit, car| profit + car.parking_cost} }"
            found_parking_spot = parking_lot.find_parking_spot_by_size(50)
            parking_lot.add_car_to_parking_spot(optimal_car_combo, found_parking_spot)
            puts "cars have been parked!"
          else
            puts "no valid multicar combination found"
          end
          break
        else
          car_size, car_brand = car_info.split(" ")
          cars.push(Car.new(car_size.to_i, car_brand))
        end
      end
    elsif car_size.to_i > 0
      car_size = car_size.to_i
      current_car = Car.new(car_size)
  
      found_parking_spot = parking_lot.find_parking_spot(current_car)
      if found_parking_spot
        puts "parking spot found, it's size is: #{found_parking_spot.size}"
        parking_lot.add_car_to_parking_spot(current_car, found_parking_spot)
        puts "Your car has been successfully parked!"
      else
        puts "sorry, no parking spots available for that car size"
      end
    else
      puts "invalid input, try again"
    end
    puts "--------------------------"
  end
end