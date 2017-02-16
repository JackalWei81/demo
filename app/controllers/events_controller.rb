class EventsController < ApplicationController
  authorize_resource :event
  before_action :authenticate_user!, :except => [:index]

  before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]

  #public action
  # GET /events/index
  # GET /events
  def index
    prepare_variable_for_index_template
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

    if request.xhr?
      render :layout => false
    end

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  def dashboard
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user = current_user
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
    if params[:remove_logo] == "1"
      @event.logo = nil
    end
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
    respond_to do |format|
      format.html {
        flash[:alert] = "刪除成功"
        redirect_to events_path
      }
      format.js #destroy.js.erb
    end
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

  def join
    @event = Event.find(params[:id])
    Membership.find_or_create_by( :event_id => @event.id, :user_id => current_user.id )

    redirect_to :back
  end

  def withdraw
    @event = Event.find(params[:id])
    @membership = Membership.find_by( :event_id => @event.id, :user_id => current_user.id )
    @membership.destroy

    redirect_to :back
  end

  #private method
  def event_params
    params.require(:event).permit(:name, :logo, :description, :category_id, :location_attributes => [:id, :name, :_destroy] )
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def prepare_variable_for_index_template

    if params[:keyword]
      @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    else
      @events = Event.order("id DESC")
    end

    #這邊先判斷有沒有:order，在判斷是否確定為"name"，是為了安全檢查，最好都是這樣做安全機制確認
    if params[:order]
      sort_by = (params[:order]=="name") ? "name" : "id"
      @events = @events.order(sort_by)
    end

    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true)
    @events = @events.page(params[:page]).per(5)
  end
end
