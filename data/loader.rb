require 'models'
require 'date'

module Loader
  def self.load_from_file(path)
    fmt = '%Y-%m-%dT%H:%M:%S.%LZ'
    csv = CSV.read(path, :headers => true)
    csv.map { |row|
      begin
        person = Models::Person.create(name: row[0])
      rescue Sequel::Error => e
        person = Models::Person.first(name: row[0])
      end

      eaten = DateTime.strptime(row[2], fmt).to_date

      begin
        Models::Pizza.create(type: row[1], person_id: person.id, eaten_at: eaten)
      rescue Sequel::Error => e
        puts e.message
      end
    }
  end
end