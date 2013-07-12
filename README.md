# Batch Geocode (Ruby)

Script that takes in a CSV of addresses and geocodes them using the Geocoder ruby gem

## Installation

```
git clone git@github.com:derekeder/batch-geocode.git
cd batch-geocode
bundle
```

### Set up config.yml
```
cp config.yml.example config.yml
```

Set your input and output files, as well as your API key for the geocoder service (using Bing for now).

## Usage

```
ruby batch_geocode.rb
```

## Dependencies

* Ruby 1.9.3
* [Geocoder](https://github.com/alexreisner/geocoder) gem