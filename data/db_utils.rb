require "sequel"
require "csv"
require "date"

module Connection

  def self.config
    {
      host: 'localhost',
      database: 'pizza',
      user: 'pizza'
    }
  end

  def self.check
    begin
      Sequel.postgres(self.config) do |db|

      end
    rescue Sequel::Error => e
      puts e.message
    end
  end
end

module Db

  def self.init(cfg)
    Sequel.postgres(cfg) do |db|
      db.create_table?(:people) do
        primary_key :id
        String :name, :unique => true
      end

      db.create_table?(:pizzas) do
        primary_key :id
        String :type
        foreign_key :person_id, :people
        DateTime :eaten_at
      end
    end
  end

  def self.load_from_file(path)
    csv = CSV.read(path, :headers => true)
    csv.map { |row|

    }
  end
end