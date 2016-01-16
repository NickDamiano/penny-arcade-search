# go to today and 

require 'wombat'

  class Scraper

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      #initialize empty array to push html array resaults in. verify 404 in save
      @results = []
      @date_range = Array (@start_date..@end_date)

    end

    def scrapePage(comic_date)
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
      # Push the result into instance variable array to be processed in save
      @results.push(result)
    end

    # Builds an array of comic
    #   date parameters are date stamps and to be compared
    def run
      comics      = []
      thread_list = []
      until @date_range.empty? do 
        chunk = @date_range.shift(50)
        chunk.each do |day|
          thread_list << Thread.new do 
            Thread.abort_on_exception=true
            begin
              scrapePage(day)
            rescue Exception => e
              p "fuck something went wrong"
              p e.message
            end
          end
        end
        thread_list.each { |thread| thread.join }
      end      
      saveComics(comics)              # call the save comics method with the array of hashes to be stored at once. 
    end

    def saveComics
      comics = @results
      comics_to_save = []
      comics.each do |comic|
        # This code allows the image for the lastest /comic to be saved, since /comic is slightly different than /comic/some-date
        unless comic["headline"] == "404"
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
      end
      Comic.import comics_to_save
      p 'finished saving perhaps'
    end
  end

