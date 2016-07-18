# app/controllers/api_v1/events_controller.rb
class ApiV1::EventsController < ApiController
  before_action :authenticate_user!

  def show
    @events = Event.all
    #render :json => @event.to_json
  end
end
