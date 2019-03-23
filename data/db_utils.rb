module Connection
  require "sequel"

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