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
      # Add threading here?
      while ( date < end_date )

        result = scrapePage(date)

        if result["headline"] != "404"
          comics.push(result)
        end
        date = date + 1 
      end 
      p comics 
      saveComics(comics)
    end

    def self.saveComics(comics)
      # this code will iterate through the comics array and build out another array of active record
      #   comic records. Then it will write it all at once using activerecord import
      # 
      # books = []
      # 10.times do |i| 
      #   books << Book.new(:name => "book #{i}")
      # end
      # Book.import books
      comics_to_save = []
      comics.each do |comic|
        split_page = comic[page_url].split('/')
        date = Date.new(split_page[4], split_page[5], split_page[6])
        comics_to_save << Comic.new(page_url: comic["page_url"], 
          img_url: comic["img_url"], publish_date: date)
      end
      Comic.import comics_to_save
    end
  end
end

### Practice code

today = Date.new(2015, 2, 15)
end_date = Date.today
test = PennyArcadeSearch::ComicScraper.run(today, end_date)
# test = PennyArcadeSearch::ComicScraper.scrapePage(today + 1)
p test
# comic = Comic.create(img_url: test["img_url"])


