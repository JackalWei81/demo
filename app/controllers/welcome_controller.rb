class WelcomeController < ApplicationController

  def index
  end

  def say
  end

  def something

    respond_to  do |format|
      format.html {
        render :text => "<h3>AWESOME!! #{Time.now}</h3>"
      }
      format.js #somrthing.js.erb
    end

  end
end
