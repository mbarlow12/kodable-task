module Controllers

  def get_all_users
    [1]
  end

  class Users

    def self.all
      @users || []
    end

    def self.fetch(source)
      @users = source.get_all_users
    end
  end

  module_function :get_all_users
end
