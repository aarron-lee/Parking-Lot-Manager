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

  for(i = 0; i < number_of_levels; i++) do
    
  end


end