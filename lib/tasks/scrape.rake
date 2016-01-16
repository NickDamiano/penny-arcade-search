namespace :scrape do 
  desc 'Scrapes Penny Arcade Comics from first in 1998 to today'
  task :all => :environment do 
    p 'Starting scrape from 1998 to today'
    # start_date = Date.new(1998, 11, 18)
    start_date = Date.new(1998, 11, 18)
    end_date = Date.today
    date_range = Array (start_date..end_date)
    # until that array is empty, pop off 50 dates and process them
    until date_range.empty? do
      chunk = date_range.shift(50)
      Scraper.run(chunk)
    end
    Scraper.run(chunk)
    p 'Scrape complete!'
  end

  desc 'Scrapes the newest comics not in the database'
  task :recent => :environment do 
    p 'scraping newest comics not in the database'
    if Comic.all.count == 0
      p "There are no comics - starting from beginning"
      start_date = Date.new(1998, 11, 18)
    else
      start_date = Comic.reorder('publish_date').last.publish_date
    end
    start_date = (start_date + 1).to_s
    p "Starting scrape on #{start_date}"
    date = start_date.split('-').map{|num| num.to_i}
    start_date = Date.new(date[0], date[1], date[2])
    p "Start date is #{start_date}"
    end_date = Date.today
    # create an array of date objects 
    date_range = Array (start_date..end_date)
    # until that array is empty, pop off 50 dates and process them
    until date_range.empty? do
      chunk = date_range.shift(50)
      begin
        Scraper.run(chunk)
      rescue
        sleep(45)
        retry
      end
    end
    p 'Scrape complete!'
  end
end