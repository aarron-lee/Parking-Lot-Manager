# Parking Lot Manager

Basic Parking Lot Management software for coding challenge @ Cipherhealthg

## How To Use

in terminal:
`ruby parking.rb`

You can provide an additional command line arg for to specify the number of parking levels in the parking lot (e.g. `ruby parking.rb 10`)

Once you start the program, you will be prompted with the following:

```Input the size of the car you would like to park,
  OR
  'm' for multicar parking,
  'p' to see available parking spots,
  'q' to quit:
```

You can either enter a car size (e.g. 20), or 'm' for multicar parking in a single parking spot, or 'p' to see which parking spots are available (occupied spots are marked with "X"), or 'q' to quit

For multicar parking, you must put in multiple car sizes, as well as their respective brand. Type in 'stop' to finish adding cars

e.g.

```
type in each car size and brand, as SIZE BRAND, followed by the 'Enter' key (e.g. '15 Dodge', or '45 Jaguar').
type in 'stop' to stop adding cars

> 15 Dodge
> 45 Jaguar
> 10 Mercedes
> 20 Audi
> stop
>
```

This should print out the optimal profit, and park the cars.
e.g.
`optimal profit value is: $180, cars have been parked!`
