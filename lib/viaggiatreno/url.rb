module Viaggiatreno
  module URL
    BASE = "http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno"

    # Viaggiatreno::URL.train_status
    def self.train_status(dep_station_code, train_code)
      base("andamentoTreno", dep_station_code, train_code)
    end


    def self.first_station(train_code)
      base("cercaNumeroTrenoTrenoAutocomplete", train_code)
    end

    def self.stations_began_with(string)
      base("autocompletaStazione", string)
    end

    def self.station_basic_info(station_name)
      base("cercaStazione", station_name)
    end

    def self.region_of_station(station_code)
      base("regione", station_code)
    end


    def self.station_info(station_code, region_code)
      base("dettaglioStazione", station_code, region_code)
    end

    private

    def self.base(function_name, *params)
      "#{BASE}/#{function_name}/#{params.join('/')}"
    end    
  end

end
