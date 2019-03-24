require "grape"
require "sequel"
require "Controllers"

module Kodable

  class API < Grape::API

    prefix "api"
    format :json

    get :people do
      { :people => Controllers::get_all_people.map { |p| { :id => p.id, :name => p.name } } }
    end

    get :consumptions do
      { :consumptions => Controllers::get_all_consumptions }
    end

    get :streaks do
      { :streaks => Controllers.get_streaks }
    end

    resource :max do
      route_param :month do
        get do
          Controllers::get_month_max(params[:month].downcase)
        end
      end
    end

  end

end