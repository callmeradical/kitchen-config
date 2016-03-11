require 'rspec'
require 'simplecov'
require 'simplecov-rcov'
require 'yaml'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start

Dir['./lib/**/*.rb'].reverse_each { |file| require file }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  RSpec::Mocks.configuration.verify_partial_doubles = true
  config.order = 'random'
end
