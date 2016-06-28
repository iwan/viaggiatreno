require 'json' # toglimi
module Viaggiatreno
  class ResultParser
    class << self
      
      def train_numbers(result)
        return [] if result.nil?
        result.split("\n").map do |r|
          a  = r.split("|")
          b  = a.first.split(" - ")
          { station_code: a.last.split("-").last, train_code: b.first }
        end
      end


      def train_status(result)
        return nil if result.nil?
        TrainStatus.new JSON.parse(result)
      end


      def stations_began_with(result)
        return [] if result.nil?
        result.split("\n").map do |r|
          a  = r.split("|")
          { station_name: a.first, station_code: a.last }
        end
      end


      def station_basic_info(result)
        return nil if result.nil?
        JSON.parse(result).map do |s| # {"nomeLungo"=>"CREMONA", "nomeBreve"=>"Cremona", "label"=>"Cremona", "id"=>"S01915"}
          {
            long_name:  s["nomeLungo"],
            short_name: s["nomeBreve"],
            label:      s["label"],
            id:         s["id"]            
          }
        end
      end


      def region_of_station(result)
        return nil if result.nil?
        regions = {
          1 => "Lombardia",
          2 => "Liguria",
          3 => "Piemonte",
          4 => "Valle d'Aosta",
          5 => "Lazio",
          6 => "Umbria",
          7 => "Molise",
          8 => "Emilia Romagna",
          10 => "Friuli Venezia Giulia",
          11 => "Marche",
          12 => "Veneto",
          13 => "Toscana",
          14 => "Sicilia",
          15 => "Basilicata",
          16 => "Puglia",
          17 => "Calabria",
          18 => "Campania",
          19 => "Abruzzo",
          20 => "Sardegna",
          22 => "Trentino Alto Adige"
        }
        num = result.to_i

        { region_code: num, region_name: regions[num] || "???"}
      end



      def station_info(result)
        return nil if result.nil?
        r = JSON.parse(result) # {"codReg"=>12, "tipoStazione"=>3, "dettZoomStaz"=>[{"codiceStazione"=>"S03200", "zoomStartRange"=>8, "zoomStopRange"=>9, "pinpointVisibile"=>true, "pinpointVisible"=>true, "labelVisibile"=>false, "labelVisible"=>false, "codiceRegione"=>nil}, {"codiceStazione"=>"S03200", "zoomStartRange"=>10, "zoomStopRange"=>11, "pinpointVisibile"=>true, "pinpointVisible"=>true, "labelVisibile"=>true, "labelVisible"=>true, "codiceRegione"=>nil}], "pstaz"=>[], "mappaCitta"=>{"urlImagePinpoint"=>"", "urlImageBaloon"=>""}, "codiceStazione"=>"S03200", "codStazione"=>"S03200", "lat"=>45.781438, "lon"=>12.832375, "latMappaCitta"=>0.0, "lonMappaCitta"=>0.0, "localita"=>{"nomeLungo"=>"PORTOGRUARO CAORLE", "nomeBreve"=>"Portogruaro C.", "label"=>"Portogruaro", "id"=>"S03200"}, "esterno"=>false, "offsetX"=>106, "offsetY"=>20, "nomeCitta"=>"Portogruaro"}
        {
          region_code:  r["codReg"],
          station_code: r["codiceStazione"],
          latitude:     r["lat"],
          longitude:    r["lon"],
          long_name:    r["localita"]["nomeLungo"],
          short_name:   r["localita"]["nomeBreve"],
          label:        r["localita"]["label"],
          id:           r["localita"]["id"],  
          city_name:    r["nomeCitta"]
        }
      end
    end
  end
end