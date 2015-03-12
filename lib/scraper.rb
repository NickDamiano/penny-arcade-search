# go to today and 

require 'wombat'

class ComicScraper

  self.

test = Wombat.crawl do 
  base_url 'http://www.penny-arcade.com'
  path '/comic'

  headline xpath: '//h2'

  # Below gets the page url
  page_url xpath: "//*[@id = 'comicFrame']//@href"

  # Below gets the img url
  img_url xpath: "//*[@id = 'comicFrame']/a/img//@src"

end

p test
comic = ::Comic.create(img_url: test["img_url"])
p comic.id
p 'id'

end