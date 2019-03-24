require 'sequel'
require 'db_utils'

def init
  if ENV['environment'] == 'testing'
    db = Sequel.sqlite('test.db')
  else
    db = Sequel.postgres(Connection.config)
  end

  db.create_table?(:people) do
    primary_key :id
    String :name, :unique => true
  end

  db.create_table?(:pizzas) do
    primary_key :id
    String :type
    foreign_key :person_id, :people
    Date :eaten_at
  end
end

init()

module Models
  class Person < Sequel::Model
  end

  class Pizza < Sequel::Model
    dataset_module do
      def all_pizzas_with_people
        join(:people, id: :person_id).all
      end

      def pizzas_grouped_by_day
        select(:eaten_at) { |r|
            Sequel.as(r.count(:eaten_at), :count)
        }.group(:eaten_at).order(:eaten_at).all
      end
    end
  end
end