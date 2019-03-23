require "grape"

module Kodable

  class API < Grape::API

    get :people do
      # open db connection
      # pass db as source to User.fetch TODO: adjust source interaction
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