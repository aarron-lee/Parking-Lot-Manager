# Parking Lot Manager

Basic Parking Lot Management software for coding challenge @ Cipherhealthg

## How To Use

in terminal:
`ruby parking.rb`

You can provide an additional command line arg for to specify the number of parking levels in the parking lot (e.g. `ruby parking.rb 10`)

Once you start the program, you will be prompted with the following:

```
Input the size of the car you would like to park,
  OR
  'm' for multicar parking,
  'p' to see available parking spots,
  'q' to quit:
```

You can either enter a car size (e.g. 20), or 'm' for multicar parking in a single parking spot, or 'p' to see which parking spots are available (occupied spots are marked with "X"), or 'q' to quit

### Multicar parking

For multicar parking, you must put in multiple car sizes, as well as their respective brand. Type in 'stop' to finish adding cars

e.g.

```
type in each car size and brand, as SIZE BRAND, followed by the 'Enter' key (e.g. '15 Dodge', or '45 Jaguar').
type in 'stop' to stop adding cars
 15 Dodge
 45 Jaguar
 10 Mercedes
 20 Audi
 stop
optimal profit value is: $180
cars have been parked!
```

### Available parking spots

By typing in 'p', you should see a print out of the parking lot levels with 'X' on any spots that are occupied. Each level is represented by a row, and the numbers are the parking spot sizes.

e.g.

```
X 10 20 X 35
35 10 25 30 35
40 50 30 30 40
45 10 10 35 45
```

### Park a single car

By typing in a valid integer (e.g. 40), it will park a car in the nearest parking spot large enough to fit that car size.
