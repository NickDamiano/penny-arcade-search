# go to today and 

require 'wombat'

  class Scraper
    def self.scrapePage(comic_date)
      # Convert date stamp to 2015-03-02
      parsed_date = comic_date.to_s.split('-')
      year        = parsed_date[0]
      month       = parsed_date[1]
      day         = parsed_date[2]
      p "Processing #{parsed_date}"

      result = Wombat.crawl do 
        base_url 'http://www.penny-arcade.com'

        path "/comic/#{year}/#{month}/#{day}"

        headline xpath: '//h2'

        # Get the img url
        img_url xpath: "//*[@id = 'comicFrame']/a/img//@src"
        img_url_last xpath: "//*[@id = 'comicFrame']/img//@src"
      end
      result["page_url"] = "http://www.penny-arcade.com/comic/#{year}/#{month}/#{day}"
      result 
    end

    # Builds an array of comic
    #   date parameters are date stamps and to be compared
    def self.run(start_date, end_date)
      comics = []
      # Below variable rename seems unnecessary TODO
      date = start_date
      
      while ( date <= end_date )
        result = scrapePage(date)
        if result["headline"] != "404"
          comics.push(result)
          p "#{result}"
        end
        date = date + 1 
        p "new date is #{date}"
      end 
      p comics 
      saveComics(comics)
    end

    def self.saveComics(comics)
      comics_to_save = []
      comics.each do |comic|
        # This code allows the image for the lastest /comic to be saved, since /comic is slightly different than /comic/some-date
        comic["img_url"] = comic["img_url"] || comic["img_url_last"]
        split_page = comic["page_url"].split('/')
        p split_page[4]
        p split_page[5]
        p split_page[6]
        if split_page[4] != nil
          date = Date.new(split_page[4].to_i, split_page[5].to_i, split_page[6].to_i)
          comics_to_save << ::Comic.new(page_url: comic["page_url"], 
            img_url: comic["img_url"], publish_date: date, comic_title: comic["headline"])
        end
      end
      Comic.import comics_to_save
      p 'finished saving perhaps'
    end
  end

