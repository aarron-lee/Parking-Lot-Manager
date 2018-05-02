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
    @parking_levels.each do |parking_level|
      parking_spot = parking_level.find_parking_spot(size)
      return true if !parking_spot.nil?
    end
    false
  end

  def find_parking_spot(car)
    @parking_levels.each do |parking_level|
      parking_spot = parking_level.find_parking_spot(car.size)
      return parking_spot if !parking_spot.nil?
    end
    nil
  end

  def add_car_to_parking_spot(car, parking_spot)
    parking_spot.park_car(car)
  end

  def print
    @parking_levels.each do |parking_level|
      parking_level.print
    end
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

  def park_car(*car)
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
  def initialize(size, brand=nil)
    raise "invalid size" if size <= 0
    @size = size
    @brand = brand || BRANDS.sample
  end

  def size
    @size
  end
end

# helper functions for command line program
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


# Command Line program
if $PROGRAM_NAME == __FILE__
  number_of_levels = ARGV[0] ? ARGV[0].to_i : 4
  parking_lot = ParkingLot.new(number_of_levels)

  seed_random_data(parking_lot)

  puts "Parking Lot:"
  parking_lot.print
  puts "------------------"

  while(true)
    puts "Input the size of the car you would like to park,\n\t'm' if multiple cars arrived at the gate,\n\t'p' to see available parking spots,\n\tor type in 'q' to quit:"
    car_size = $stdin.gets.chomp
    if car_size == 'q'
      break
    elsif car_size == 'p'
      parking_lot.print
    elsif car_size == 'm'
      puts "type in each car size and brand, as SIZE BRAND, followed by the 'Enter' key\n\t(e.g. '15 Dodge', or '45 Jaguar').\ntype in 's' to stop adding cars"
      cars = []
      while(true)
        car_info = $stdin.gets.chomp
        if car_info == 's'
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