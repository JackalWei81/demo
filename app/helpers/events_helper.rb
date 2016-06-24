module EventsHelper
  def setup_event(event)
    event.build_location unless event.location
    event
  end

  def event_join?
    @membership = Membership.find_by( :event_id => @event.id, :user_id => current_user.id )
  end
end
