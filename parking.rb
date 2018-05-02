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

  def find_parking_spot(car)
    @parking_levels.each do |parking_level|
      parking_spot = parking_level.find_parking_spot(car.size)
      return parking_spot if parking_spot
    end
  end

  def add_car_to_parking_spot(car, parking_spot)
    parking_spot.park_car(car)
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
  end
end

class ParkingSpot
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
  def initialize(size)
    @size = size
  end

  def size
    @size
  end
end

if $PROGRAM_NAME == __FILE__
  number_of_levels = ARGV[0] ? ARGV[0].to_i : 4
  parking_lot = ParkingLot.new(number_of_levels)

  number_of_levels.times do |level_number|
    random_parking_spot_sizes = []
    5.times do
      random_parking_spot_sizes.push(Random.rand(1..100))
    end
    random_parking_spot_sizes.each do |parking_spot_size|
      add_parking_spot_to_level(level_number, parking_spot_size)
    end
  end

  while(true)
    puts "input the size of the car you would like to park, or type in 'q' to quit"
    car_size = $stdin.gets.chomp
    if car_size == 'q'
      break
    end
    car_size = car_size.to_i
    current_car = Car.new(car_size)

    found_parking_spot = parking_lot.find_parking_spot(current_car)
    if found_parking_spot
      parking_lot.add_car_to_parking_spot(current_car, found_parking_spot)
      puts "Your car has been successfully parked!"
    else
      puts "sorry, no parking spots available for that car size"
    end
  end
end