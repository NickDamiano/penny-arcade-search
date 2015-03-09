# go to today and 

require 'wombat'

module PennyArcadeSearch
  class ComicScraper
    def self.scrapePage(comic_date)
      # Convert date stamp to 2015-03-02
      parsed_date = comic_date.to_s.split('-')
      year        = parsed_date[0]
      month       = parsed_date[1]
      day         = parsed_date[2]

      Wombat.crawl do 
        base_url 'http://www.penny-arcade.com'

        path "/comic/#{year}/#{month}/#{day}"

        headline xpath: '//h2'

        # Get the page url
        page_url xpath: "//*[@id = 'comicFrame']//@href"

        # Get the img url
        img_url xpath: "//*[@id = 'comicFrame']/a/img//@src"
      end
    end

    # Builds an array of comic
    #   date parameters are date stamps and to be compared
    def self.run(start_date, end_date)
      comics = []
      date = start_date

      while ( date < end_date )
        result = scrapePage(date)

        if result["headline"] != "404"
          comics.push(result)
        end
        date = date + 1 
      end 
      comics 
    end
  end
end
today = Date.new(2015, 2, 15)
end_date = Date.today
test = PennyArcadeSearch::ComicScraper.run(today, end_date)
# test = PennyArcadeSearch::ComicScraper.scrapePage(today + 1)
p test
# comic = Comic.create(img_url: test["img_url"])


