require 'spec_helper'

describe Viaggiatreno do
  it 'has a version number' do
    expect(Viaggiatreno::VERSION).not_to be nil
  end

  it "read invalid train number" do
    VCR.use_cassette("train_number_none") do
      arr = Viaggiatreno::Viaggiatreno.train_numbers(120_000)
      expect(arr).to be_an_instance_of(Array)
      expect(arr.size).to eq(0)
    end
  end

  it "read train number, single" do
    VCR.use_cassette("train_number_one") do
      arr = Viaggiatreno::Viaggiatreno.train_numbers(18)
      expect(arr).to be_an_instance_of(Array)
      expect(arr.size).to eq(1)
      expect(arr[0][:station_code]).to eq("S01700")
      expect(arr[0][:train_code]).to eq("18")
    end
  end


  it "read train number, double" do
    VCR.use_cassette("train_number_two") do
      arr = Viaggiatreno::Viaggiatreno.train_numbers(19)
      expect(arr).to be_an_instance_of(Array)
      expect(arr.size).to eq(2)
      expect(arr[0][:station_code]).to eq("S01301")
      expect(arr[0][:train_code]).to eq("19")
      expect(arr[1][:station_code]).to eq("N00001")
      expect(arr[1][:train_code]).to eq("19")
    end
  end


  it 'read train status when wrong' do
    VCR.use_cassette("train_status_none") do
      response = Viaggiatreno::Viaggiatreno.train_status("S01700", 1)
      expect(response).to be_nil
    end
  end

  it 'read train status' do
    VCR.use_cassette("train_status_one") do
      r = Viaggiatreno::Viaggiatreno.train_status("S01700", 18)
      expect(r).to be_an_instance_of(Viaggiatreno::TrainStatus)
    end
  end



  it 'read stations list that began with MIL' do
    VCR.use_cassette("stations_began_with_MIL") do
      response = Viaggiatreno::Viaggiatreno.stations_began_with("MIL")
      expect(response).to be_an_instance_of(Array)
      expect(response.size).to be > 2
      expect(response[0][:station_name]).to be_an_instance_of(String)
      expect(response[0][:station_code]).to be_an_instance_of(String)
    end
  end

  it 'read stations list that began with ZZZ' do
    VCR.use_cassette("stations_began_with_ZZZ") do
      response = Viaggiatreno::Viaggiatreno.stations_began_with("ZZZ")
      expect(response).to be_an_instance_of(Array)
      expect(response.size).to eq(0)
    end
  end


  it 'read basic info of an existing station' do
    VCR.use_cassette("cremona_station_basic_info") do
      response = Viaggiatreno::Viaggiatreno.station_basic_info("CREMONA")
      expect(response).to be_an_instance_of(Array)
      expect(response.size).to be > 0
      expect(response[0][:id]).to be_an_instance_of(String)
      expect(response[0][:label]).to be_an_instance_of(String)
      expect(response[0][:short_name]).to be_an_instance_of(String)
      expect(response[0][:long_name]).to be_an_instance_of(String)
    end
  end

  it 'read basic info of multiple stations' do
    VCR.use_cassette("milano_station_basic_info") do
      response = Viaggiatreno::Viaggiatreno.station_basic_info("MILANO")
      expect(response).to be_an_instance_of(Array)
      expect(response.size).to be > 3
      expect(response[0][:id]).to be_an_instance_of(String)
      expect(response[0][:label]).to be_an_instance_of(String)
      expect(response[0][:short_name]).to be_an_instance_of(String)
      expect(response[0][:long_name]).to be_an_instance_of(String)
    end
  end


  it 'read basic info of an inexistent station' do
    VCR.use_cassette("zzz_station_basic_info") do
      response = Viaggiatreno::Viaggiatreno.station_basic_info("ZZZ")
      expect(response).to be_an_instance_of(Array)
      expect(response.size).to eq(0)
    end
  end

  it 'read region of an existing station' do
    VCR.use_cassette("region_of_existing_station") do
      response = Viaggiatreno::Viaggiatreno.region_of_station("S03200")
      expect(response).to be_an_instance_of(Hash)
      expect(response[:region_code]).to eq(12)
      expect(response[:region_name]).to eq("Veneto")
    end
  end

  it 'read region of an inexistent station' do
    VCR.use_cassette("region_of_wrong_station") do
      response = Viaggiatreno::Viaggiatreno.region_of_station("WRONG")
      expect(response).to be_nil
    end
  end


  it 'read existing station info' do
    VCR.use_cassette("correct_station_info") do
      response = Viaggiatreno::Viaggiatreno.station_info("S03200", 12)
      expect(response).to be_an_instance_of(Hash)
      expect(response[:region_code]).to eq(12)
      expect(response[:station_code]).to eq("S03200")
    end
  end


  it 'read inexistent station info' do
    VCR.use_cassette("wrong_station_info") do
      response = Viaggiatreno::Viaggiatreno.station_info("S03200", 3)
      expect(response).to be_nil
    end
  end

end
