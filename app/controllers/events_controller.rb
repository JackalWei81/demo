class EventsController < ApplicationController

  before_action :set_event, :only => [:show, :edit, :update, :destroy]

  #public action
  # GET /events/index
  # GET /events
  def index
    @events = Event.page(params[:page]).per(5)

    #提供支援別的檔案格式
    respond_to do |format|
      format.html #index.html.erb
      format.xml {
        render :xml => @events.to_xml
      }
      format.json {
        render :json => @events.to_json
      }
      format.atom {
        @feed_title = "My event list"
      }
    end
  end


  def latest
    @events = Event.order("id DESC").limit(5)
  end

  # GET /events/:id
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
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

  def bulk_update
    ids = Array(params[:ids])
    events = ids.map{|i| Event.find_by_id(i)}.compact
    #find_by_id => 找不到值會回傳nil
    #compact會將陣列內的nil去除。

    if params[:commit] == "Publish"
      events.each{|e| e.update( :status => "published" )}
      flash[:notice] = "發佈成功"
    elsif params[:commit] == "Delete"
      events.each{|e| e.destroy}
      flash[:alert] = "刪除成功"
    end

    redirect_to events_path
  end

  #private method
  private
  def event_params
    params.require(:event).permit(:name, :description, :status, :category_id, :group_ids =>[])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
