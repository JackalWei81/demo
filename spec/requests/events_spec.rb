require 'rails_helper'
RSpec.describe "API_V1::Events", :type => :request do

  describe "GET /api/v1/events/:id" do
    it "should be return events json" do
      user = User.create!( email: "jackal@gmail.com", password: "123456")

      get v1_event_path(2)

      data = {
        "event" => []
      }

      expect(response).to have_http_status(200)

      parsed_json = JSON.parse( response.body )
      expect( parsed_json ).to eq(data)
    end
  end
end
