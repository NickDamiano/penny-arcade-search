class TaggerController < ApplicationController
  def index 
    # get the last date in the record
    last_record= Comic.reorder('publish_date').last.publish_date.to_s
    redirect_to "/tagger/#{last_record}"
    # redirect to that page for show
  end

  def show 
    date    = params[:date]
    @comic  = Comic.find_by(publish_date: date)
    @tags   = Comic
    session[:comic_id] = @comic.id
  end

  def save
    @comic  = session[:comic_id]
    @tags   = params[:tagger]
    ComicTag.save_tags(@tags, session[:comic_id])
    comic   = Comic.find(@comic-1)
    date    = comic.publish_date.to_s
    redirect_to "/tagger/#{date}"
  end
end
