class TaggerController < ApplicationController
  def show 
    date = params[:date]
    @comic = Comic.find_by(publish_date: date)
  end
end
