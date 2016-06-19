class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  #public action
  # GET /events/index
  # GET /events
  def index
    @events = Event.page(params[:page]).per(5)
  end

  # GET /events/show/:id
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events/create
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "新增成功"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  # GET /events/edit/:id
  def edit
  end

  # POST /events/update/:id
  def update
    if @event.update(event_params)
      redirect_to :action => :show, :id => @event
      flash[:notice] = "編輯成功"
    else
      render :action => :edit
    end
  end

  # GET /events/destroy/:id
  def destroy
    @event.destroy
    flash[:alert] = "刪除成功"
    redirect_to :action => :index
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
