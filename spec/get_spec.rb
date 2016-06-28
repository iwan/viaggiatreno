require 'spec_helper'

describe Viaggiatreno::Get do
  it 'get number of an not existing single train' do
    VCR.use_cassette("train_wrong_number") do
      response = Viaggiatreno::Get.train_number(120_000)
      expect(response).to(be_nil)
    end
  end

  it 'get number of an existing single train' do
    VCR.use_cassette("train_number_one") do
      response = Viaggiatreno::Get.train_number(18)
      expect(response).to match(/18 - MILANO CENTRALE|18-S01700/)
    end
  end

  it 'get numbers of an existing single train' do
    VCR.use_cassette("train_number_two") do
      response = Viaggiatreno::Get.train_numbers(19)
      expect(response).to match(/19 - CHIASSO|19-S01301\n19 - MILANO NORD CADORNA|19-N00001/)
    end
  end

  it 'get train status when wrong' do
    VCR.use_cassette("train_status_none") do
      response = Viaggiatreno::Get.train_status("S01700", 1)
      expect(response).to be_nil
    end
  end

  it 'get train status' do
    VCR.use_cassette("train_status_one") do
      response = Viaggiatreno::Get.train_status("S01700", 18)
      expect(response).to be_an_instance_of(String)
      expect(response.size).to be > 1
    end
  end




  it 'get station that began with MIL' do
    VCR.use_cassette("stations_began_with_MIL") do
      response = Viaggiatreno::Get.stations_began_with("MIL")
      expect(response).to be_an_instance_of(String)
      expect(response.size).to be > 1
    end
  end

  it 'get station that began with ZZZ' do
    VCR.use_cassette("stations_began_with_ZZZ") do
      response = Viaggiatreno::Get.stations_began_with("ZZZ")
      expect(response).to(be_nil)
    end
  end


  it 'get basic info of an existing station' do
    VCR.use_cassette("cremona_station_basic_info") do
      response = Viaggiatreno::Get.station_basic_info("CREMONA")
      expect(response).to be_an_instance_of(String)
      expect(response.size).to be > 1
    end
  end

  it 'get basic info of multiple stations' do
    VCR.use_cassette("milano_station_basic_info") do
      response = Viaggiatreno::Get.station_basic_info("MILANO")
      expect(response).to be_an_instance_of(String)
      expect(response.size).to be > 1
    end
  end


  it 'get basic info of an inexistent station' do
    VCR.use_cassette("zzz_station_basic_info") do
      response = Viaggiatreno::Get.station_basic_info("ZZZ")
      expect(response).to eq("[]")
    end
  end


  it 'get region of an existing station' do
    VCR.use_cassette("region_of_existing_station") do
      response = Viaggiatreno::Get.region_of_station("S03200")
      expect(response).to eq("12")
    end
  end

  it 'get region of an inexistent station' do
    VCR.use_cassette("region_of_wrong_station") do
      response = Viaggiatreno::Get.region_of_station("WRONG")
      expect(response).to be_nil
    end
  end

  it 'get existing station info' do
    VCR.use_cassette("correct_station_info") do
      response = Viaggiatreno::Get.station_info("S03200", 12)
      expect(response).to be_an_instance_of(String)
      expect(response.size).to be > 1
    end
  end


  it 'get inexistent station info' do
    VCR.use_cassette("wrong_station_info") do
      response = Viaggiatreno::Get.station_info("S03200", 3)
      expect(response).to be_nil
    end
  end
end
