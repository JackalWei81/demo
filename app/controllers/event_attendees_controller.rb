class EventAttendeesController < ApplicationController

  before_action :set_event

  def index
    @attendees = @event.attendees
  end

  def show
    @attendee = @event.attendees.find(params[:id])
  end

  def new
    @attendee = @event.attendees.build
    # @attendee = @event.attendees.new => 相同寫法
  end

  def create
    @attendee = @event.attendees.build(attendee_params)

    if @attendee.save
      redirect_to event_attendees_path(@event)
    else
      render :action => :new
    end
  end

  def edit
    @attendee = @event.attendees.find(params[:id])
  end

  def update
    @attendee = @event.attendees.find(params[:id])

    if @attendee.update(attendee_params)
      redirect_to event_attendees_path
    else
      render :action => :edit
    end
  end

  def destroy
    @attendee = @event.attendees.find(params[:id])

    @attendee.destroy
    redirect_to event_attendees_path(@event)
  end


  protected

  def set_event
    #這邊必須用:event_id代表是哪一個event，若直接使用:id，抓的是attendee的id
    @event = Event.find(params[:event_id])
  end

  def attendee_params
    params.require(:attendee).permit(:name)
    #require內放的是hash的key，permit他底下的value值
  end
end
