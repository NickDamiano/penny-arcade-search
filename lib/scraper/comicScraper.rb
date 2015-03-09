# go to today and 

require 'wombat'

module PennyArcadeSearch
  class ComicScraper
    def self.scrapePage(comic_date)
      parsed_date = comic_date.split('-')
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

    def self.runScraper(start_date, end_date)
      
    end
  end
end
test = PennyArcadeSearch::ComicScraper.scrapeComic('2015-02-02')
p test
# comic = Comic.create(img_url: test["img_url"])


