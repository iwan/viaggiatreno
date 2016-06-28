require 'coveralls'
require 'pry'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Coveralls.wear!

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
  # config.allow_http_connections_when_no_cassette = true
end

require 'viaggiatreno'

# https://robots.thoughtbot.com/how-to-stub-external-services-in-tests
# https://github.com/bblimke/webmock
# https://github.com/vcr/vcr
