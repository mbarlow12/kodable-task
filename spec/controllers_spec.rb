$:.unshift File.absolute_path(File.join(File.dirname(__FILE__), '..', "data"))

require "spec_helper"
require "Controllers"
require "db_utils"
require "loader"

describe Controllers do
  before(:all) do
    Loader.load_from_file(File.absolute_path(File.join(File.dirname(__FILE__), '..', "data/data.csv")))
  end

  after(:all) do
    File.delete('test.db')
  end
  describe 'env test' do
    it "should return the ENV value" do
      expect(ENV["environment"]).to eql("testing")
    end
  end
  describe 'get_all_people' do
    it "should return all users after fetch" do
      expect(Controllers::get_all_people.length).to eql(3)
    end
  end

  describe 'get_all_consumptions' do
    it "should return all records from the consumption table" do
      expect(Controllers::get_all_consumptions.length).to eql(25)
    end
  end

  describe 'get day consumption counts' do
    it "should return as list of streaks" do
      res = Controllers::get_streaks
      expect(res).not_to be_empty
      res.each do |streak|
        last = nil
        streak.inject do |last, curr|
          if last
            expect(curr[:count]).to be > last[:count]
            expect(curr[:date]).to be > last[:date]
          end
          last = curr
        end
      end
    end
  end

  describe 'get max day per month' do
    it "should return 1/7 for january" do
      max_day = Controllers::get_month_max('january')
      expect(max_day[:date]).to eql('2015-01-07')
      expect(max_day[:month]).to eql('january')
    end
  end
end
