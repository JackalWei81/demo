class WelcomeController < ApplicationController

  def index
  end

  def say
  end

  def something
    render :text => "<h3>AWESOME!! #{Time.now}</h3>"
  end
end
