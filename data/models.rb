require 'sequel'
require 'db_utils'

DB = Sequel.postgres(Connection.config)

class Person < Sequel::Model
end

class Pizza < Sequel::Model
end
