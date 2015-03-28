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
    @tags   = @comic.tags.map{|tag_object| tag_object.tagname }
    @tags   = @tags.join(', ')
    p @tags
    session[:comic_id] = @comic.id
  end

  def save
    @comic  = session[:comic_id]
    @tags   = params[:tagger]
    ComicTag.save_tags(@tags, session[:comic_id])
    current_comic   = Comic.find(@comic)
    comic = current_comic.previous
    date    = comic.publish_date.to_s
    redirect_to "/tagger/#{date}"
  end
end
