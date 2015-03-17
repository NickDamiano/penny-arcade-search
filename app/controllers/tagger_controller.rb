class TaggerController < ApplicationController
  def show 
    date = params[:date]
    @comic = Comic.find_by(publish_date: date)
  end

  def save
    p params
    p 'PARAMALAMA DING DONG'
    @tags = params[:tag]
    ComicTag.save_tags(@tags)

  end
end
