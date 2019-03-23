require "Controllers"

describe Controllers do
  describe 'Users' do

    describe 'all' do
      it "should return 0 users without fetch" do
        expect(Controllers::Users.all.length).to eql(0)
      end

      it "should return all users after fetch" do
        mock_source = double("test source", :get_all_users => [1,2,3])
        Controllers::Users.fetch(mock_source)
        expect(Controllers::Users.all.length).to eql(3)
      end
    end
  end
end
