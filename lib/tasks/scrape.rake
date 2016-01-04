namespace :scrape do 
  desc 'Scrapes Penny Arcade Comics from first in 1998 to today'
  task :all => :environment do 
    p 'Starting scrape from 1998 to today'
    # start_date = Date.new(1998, 11, 18)
    start_date = Date.new(1998, 11, 18)
    end_date = Date.today
    Scraper.run(start_date, end_date)
    p 'Scrape complete!'
  end

  desc 'Scrapes the newest comics not in the database'
  task :recent => :environment do 
    p 'scraping newest comics not in the database'
    start_date = Comic.reorder('publish_date').last.publish_date
    start_date = (start_date + 1).to_s
    p "Starting scrape on #{start_date}"
    date = start_date.split('-').map{|num| num.to_i}
    start_date = Date.new(date[0], date[1], date[2])
    p "Start date is #{start_date}"
    end_date = Date.today
    Scraper.run(start_date, end_date)
    p 'Scrape complete!'
  end
end