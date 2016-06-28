require 'http'
require_relative "url" # da togliere
require_relative "result_parser" # da togliere
require 'net/http'

module Viaggiatreno

  # Simple methods to query Viaggiatreno API
  # Not suitable for massive query... (too slow)
  class Get
    class << self
      # get the pair train_number - departure station code
      def train_numbers(train_code)
        url = URL.train_numbers(train_code)
        exe_get url
      end
      alias_method :train_number, :train_numbers


      def train_status(dep_station_code, train_code)
        url = URL.train_status(dep_station_code, train_code)
        exe_get url
      end

      # get the list of station whose name starts with a given string url
      def stations_began_with(string)
        url = URL.stations_began_with(string)
        exe_get url
      end

      def station_basic_info(station_name)
        url = URL.station_basic_info(station_name)
        exe_get url
      end

      def region_of_station(station_code)
        url = URL.region_of_station(station_code)
        exe_get url
      end

      def station_info(station_code, region_code)
        url = URL.station_info(station_code, region_code)
        exe_get url
      end

      private

      def exe_get(url)
        res = Net::HTTP.get_response(URI(url)).body
        res = nil if res==""
        res
      end
    end
  end
end

# puts Viaggiatreno::Get.train_number(18)
# puts Viaggiatreno::Get.train_status("S01700", 18)
# (1..99).each do |n|
#   puts Viaggiatreno::Get.train_number(n)
#   puts "-----------"
# end


# puts Viaggiatreno::Get.stations_began_with("PAV")
# puts Viaggiatreno::Get.stations_began_with("PAV")

# puts Viaggiatreno::Get.station_basic_info("PAVI")

# response = HTTP.get(URI(URL.first_station(4600))).to_s
# puts response.inspect