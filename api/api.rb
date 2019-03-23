require "grape"
require "sequel"

module Kodable

  class API < Grape::API

    prefix "api"
    format :json

    get :people do
      { :people => Person.all.map { |p| { :id => p.id, :name => p.name } } }
    end

    get :consumptions do
    end

    get :streaks do
    end

    namespace :max do
      params do

      end
    end

  end

end