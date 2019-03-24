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
      Sequel.postgres(self.config) { |db| }
    rescue Sequel::Error => e
      return false
    end
    return true
  end

  def self.clean_db(db)
    db.drop_table(:pizzas)
    db.drop_table(:people)
  end
end