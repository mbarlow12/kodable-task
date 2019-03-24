$:.unshift "./api", "./data", "./lib"

require "models"
require "api"
require "loader"

Loader.load_from_file('./data/data.csv')

api = Kodable::API.new
puts api.to_s

run api