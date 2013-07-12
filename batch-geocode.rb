#!/usr/bin/env ruby

require 'csv'
require 'date'
require 'yaml'
require 'geocoder'

SEP = ","

# helper functions
def header(hash)
  hash.keys.join SEP
end

def to_csv(hash)
  hash.values.map do |value|
    escape value unless value.nil?
  end.join SEP
end

# get login and fusion table settings
begin
  yaml = YAML.load_file("config.yml")
  @input_file = yaml['input_file']
  @output_file = yaml['output_file']
  @geocoder_api_key = yaml['geocoder_api_key']

rescue Errno::ENOENT
  puts "config file not found"
end

if File.exist?(@output_file) 
  puts 'CSV file exists - deleting'
  File.delete(@output_file)
end

# Geocoder.configure(

#   # geocoding service (see below for supported options):
#   :lookup => :mapquest,

#   # to use an API key:
#   :api_key => @geocoder_api_key
# )

puts "reading address file"
# write to CSV
CSV.open(@output_file, "wb") do |csv|

  id_count = 1
  CSV.foreach(@input_file, 
              :headers           => true,
              :header_converters => :symbol) do |line|

    begin                                        
      line[:id] = id_count
      full_address = line[:full_address]
      line[:latitude], line[:longitude] = Geocoder.coordinates(full_address)

      puts "#{full_address}: #{line[:latitude]}, #{line[:longitude]}"

      csv << line
    rescue
      puts 'processing error'
      puts line.inspect
    end
    id_count = id_count + 1
    sleep 1
  end
end

puts "done"
nil