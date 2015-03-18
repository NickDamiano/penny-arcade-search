class TaggerController < ApplicationController
  def index 
  end
  
  def show 
    date = params[:date]
    @comic = Comic.find_by(publish_date: date)
    session[:comic_id] = @comic.id
  end

  def save
    p params
    @comic = session[:comic_id]
    p @comic
    p 'PARAMALAMA DING DONG'
    @tags = params[:tagger]
    ComicTag.save_tags(@tags, session[:comic_id])
  end
end
