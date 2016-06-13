module Viaggiatreno
  module URL
    BASE = "http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno"

    # get the train status url
    def self.train_status(dep_station_code, train_code)
      base("andamentoTreno", dep_station_code, train_code)
    end

    # get the deprture station of the train url
    def self.first_station(train_code)
      base("cercaNumeroTrenoTrenoAutocomplete", train_code)
    end

    # get the list of station whose name starts with a given string url
    def self.stations_began_with(string)
      base("autocompletaStazione", string)
    end

    # get basic info about station url
    def self.station_basic_info(station_name)
      base("cercaStazione", station_name)
    end

    # get the station region url
    def self.region_of_station(station_code)
      base("regione", station_code)
    end

    # get station info url
    def self.station_info(station_code, region_code)
      base("dettaglioStazione", station_code, region_code)
    end

    private

    def self.base(function_name, *params)
      "#{BASE}/#{function_name}/#{params.join('/')}"
    end    
  end

end
