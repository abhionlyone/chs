require 'rails_helper'

RSpec.describe ReadingsController, type: :controller do

  describe "POST #create reading" do
    before do
      thermostat = create(:thermostat)
      reading = build(:reading, thermostat_id: thermostat.id)
      post :create, params: { reading: reading.attributes }
    end
    it "returns http success" do
      expect(Reading.count).to eq 0 # Value not saved in db yet
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show reading" do
    before do
      thermostat = create(:thermostat)
      reading = build(:reading, thermostat_id: thermostat.id)
      @reading = StoreReading.new(reading).process
      get :show, params: { id: @reading.id }
    end
    it "returns http success" do
      res = JSON.parse(response.body)
      expect(res['id']).to eq @reading.id
      expect(Reading.count).to eq 0 # Value not saved in db yet
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #stats for a thermostat" do
    before do
      thermostat = create(:thermostat)
      Rails.cache.delete("stats_#{thermostat.id}")
      reading = build(:reading, thermostat_id: thermostat.id)
      reading = StoreReading.new(reading).process
      get :stats, params: { id: reading.thermostat_id }
    end
    it "returns http success" do
      res = JSON.parse(response.body)
      expect(Reading.count).to eq 0 # Value not saved in db yet
      expect(res["readings_count"]).to eq 1 # Total readings count for the thermostat including yet to be saved readings
      expect(response).to have_http_status(:success)
    end
  end
end