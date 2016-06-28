require 'ostruct'
module Viaggiatreno
  class TrainStatus < SimpleDelegator
    def initialize(hash)
      hash["fermate"] = (hash[:fermate] || []).map{|e| OpenStruct.new(e)}
      super OpenStruct.new(hash)
    end
  end
end

# ts = Viaggiatreno::TrainStatus.new({a: 1, b: 2, fermate: [{c: 3}, {d: 4, e: 5}]})
# puts ts.fermate.first.d
# puts ts.a
# puts ts[:a]
# puts ts["a"]
