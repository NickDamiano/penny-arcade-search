class ScraperController < ApplicationController
  def index
    today = Date.new(2015, 2, 15)
    end_date = Date.today
    test = PennyArcadeSearch::ComicScraper.run(today, end_date)
  end
end
