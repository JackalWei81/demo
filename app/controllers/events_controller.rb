class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  #public action
  # GET /events/index
  # GET /events
  def index
    @events = Event.page(params[:page]).per(5)
  end

  # GET /events/:id
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "新增成功"
      redirect_to events_path
    else
      render new_event_path
    end
  end

  # GET /events/:id/edit
  def edit
  end

  # PATCH /events/:id
  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
      flash[:notice] = "編輯成功"
    else
      render edit_event_path(@event)
    end
  end

  # DELETE /events/:id
  def destroy
    @event.destroy
    flash[:alert] = "刪除成功"
    redirect_to events_path
  end


  #private method
  private
  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
