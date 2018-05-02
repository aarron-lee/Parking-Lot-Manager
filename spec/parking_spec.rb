require_relative '../parking.rb'

RSpec.describe ParkingLot do
  it "creates parking levels equal to the number provided" do
    parking_lot = ParkingLot.new(5)
    expect(parking_lot.number_of_levels).to eq 5
  end

  it "finds no parking spots if none have been added" do
    parking_lot = ParkingLot.new(5)
    expect(parking_lot.find_parking_spot_by_size(50)).to eq nil
  end

  it "finds a parking spot if one has been added" do
    parking_lot = ParkingLot.new(5)
    parking_lot.add_parking_spot_to_level(1, 50)
    expect(parking_lot.find_parking_spot_by_size(50)).not_to eq nil
  end

  it "finds an available parking spot for a car" do
    parking_lot = ParkingLot.new(5)
    parking_lot.add_parking_spot_to_level(1, 50)

    current_car = Car.new(30, "Dodge")
    found_parking_spot = parking_lot.find_parking_spot(current_car)

    expect(found_parking_spot).not_to eq nil
  end

  it "does not find an available parking spot for a car that is too big" do
    parking_lot = ParkingLot.new(5)
    parking_lot.add_parking_spot_to_level(1, 30)

    current_car = Car.new(40, "Dodge")
    found_parking_spot = parking_lot.find_parking_spot(current_car)

    expect(found_parking_spot).to eq nil
  end

  it "finds an optimal combo for multicar parking" do
    parking_lot = ParkingLot.new(5)
    parking_lot.add_parking_spot_to_level(1, 50)

    car_values = [ [15, "Dodge"], [45, "Jaguar"], [10, "Mercedes"], [20, "Audi"] ]

    cars = car_values.map do |values|
      Car.new(values[0], values[1])
    end

    optimal_car_combo = parking_lot.find_optimal_multicar_combination(cars)

    expect(optimal_car_combo.length).to be >= 1
    expect(optimal_car_combo.reduce(0){|net_profit, car| net_profit + car.parking_cost}).to be 180
  end
end