require 'rails_helper'
RSpec.describe "API_V1::Events", :type => :request do

  example "should get events list" do
    get "/api/v1/events"
    expect(response).to have_http_status(200)
    expect( JSON.parse(response.body) ).to eq( [] )
  end
end