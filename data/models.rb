require 'sequel'
require 'db_utils'

DB = Sequle.postgres(Connection.config)

Sequel::Model.plugin :schema

class Person < Sequel::Model

  set_schema do
    primary_key :id
    String :name
  end

  create_table unless table_exists?
end

class Pizza < Sequel::Model

  set_schema do
    primary_key :id
    String :type
    foreign_key :person_id, 
  end
