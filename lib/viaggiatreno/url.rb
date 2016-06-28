module Viaggiatreno
  class URL
    BASE = "http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno"

    class << self
      # get the departure station of the train url
      def train_numbers(train_code)
        base("cercaNumeroTrenoTrenoAutocomplete", train_code)
      end

      # get the train status url
      def train_status(dep_station_code, train_code)
        base("andamentoTreno", dep_station_code, train_code)
      end

      # get the list of station whose name starts with a given string url
      def stations_began_with(string)
        base("autocompletaStazione", string)
      end

      # get basic info about station url
      def station_basic_info(station_name)
        base("cercaStazione", station_name)
      end

      # get the station region url
      def region_of_station(station_code)
        base("regione", station_code)
      end

      # get station info url
      def station_info(station_code, region_code)
        base("dettaglioStazione", station_code, region_code)
      end

      private

      def base(function_name, *params)
        "#{BASE}/#{function_name}/#{params.join('/')}"
      end  
    end
  end
end

# puts Viaggiatreno::URL::BASE
# puts Viaggiatreno::URL.train_numbers(22)
# puts Viaggiatreno::URL.train_status("N00001", 18)


