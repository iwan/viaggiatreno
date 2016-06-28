require_relative "get" # da togliere
require_relative "result_parser" # da togliere
require_relative "train_status" # da togliere

module Viaggiatreno
  class Viaggiatreno


    class << self
      # return an array of hashes, for example:
      # [{:station_code=>"S03015", :train_code=>"31"}, {:station_code=>"N00001", :train_code=>"31"}]
      def train_numbers(train_code)
        result = Get.train_numbers(train_code)
        array = ResultParser.train_numbers(result)
      end


      def train_status(dep_station_code, train_code)
        result = Get.train_status(dep_station_code, train_code)
        ResultParser.train_status(result) # TrainStatus object
      end


      def stations_began_with(string)
        result = Get.stations_began_with(string)
        ResultParser.stations_began_with(result)
      end


      def station_basic_info(station_name)
        result = Get.station_basic_info(station_name)
        ResultParser.station_basic_info(result)
      end


      def region_of_station(station_code)
        result = Get.region_of_station(station_code)
        ResultParser.region_of_station(result)
      end


      def station_info(station_code, region_code)
        result = Get.station_info(station_code, region_code)
        ResultParser.station_info(result)
      end

    end

  end
end

# include Viaggiatreno
# puts Viaggiatreno::Viaggiatreno.train_numbers("4600") # single solution
# Viaggiatreno.first_stations("22") # double solution
# Viaggiatreno.first_stations("31333") # no solution

# Viaggiatreno.train_status("S01700", "22")
# Viaggiatreno.train_status("N00201", "22")
# puts Viaggiatreno.stations_began_with("PAV").inspect


# puts Viaggiatreno::Viaggiatreno.station_basic_info("MILANO")
# puts Viaggiatreno::Viaggiatreno.station_info("S03200", 12)

