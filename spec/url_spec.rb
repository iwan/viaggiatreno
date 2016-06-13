require 'spec_helper'

describe Viaggiatreno::URL do
  it 'get train status URL' do
    expect(Viaggiatreno::URL.train_status("S03200", "128")).to eq("http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/andamentoTreno/S03200/128")
  end

  it 'get first station URL' do
    expect(Viaggiatreno::URL.first_station("656")).to eq("http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/cercaNumeroTrenoTrenoAutocomplete/656")
  end

  it 'get station list URL' do
    expect(Viaggiatreno::URL.stations_began_with("MIL")).to eq("http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/autocompletaStazione/MIL")
  end

  it 'get station basic info URL' do
    expect(Viaggiatreno::URL.station_basic_info("S03200")).to eq("http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/cercaStazione/S03200")
  end

  it 'get region of station URL' do
    expect(Viaggiatreno::URL.region_of_station("S03200")).to eq("http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/regione/S03200")
  end

  it 'get station info URL' do
    expect(Viaggiatreno::URL.station_info("S03200", 2)).to eq("http://www.viaggiatreno.it/viaggiatrenonew/resteasy/viaggiatreno/dettaglioStazione/S03200/2")
  end
end
