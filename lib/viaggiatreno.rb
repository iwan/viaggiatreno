require 'http'
require 'json'
require 'ostruct'


%w(
  version
  url
  get
  viaggiatreno
  result_parser
  train_status
).each { |file| require File.join(File.dirname(__FILE__), 'viaggiatreno', file) }


module Viaggiatreno
  # Your code goes here...
end

