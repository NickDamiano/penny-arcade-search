class SearchController < ApplicationController
  def show
    # make show erb page with search bar centered up top - 
    # make partial for results
    # when someone types in a search term it will run a script that and hits enter
    #    or submit, it will make an ajax call to the database for that entire term
    #    and the individual words
    #     example: call of duty modern warfare
    #     select comics from database where tagname is call of duty modern warfare or - call or of or duty or
    #     modern or warfare
    #     so if i type wow fart it will show the result for wow but not wow fart. 
    # or maybe it does a call for each one - then tells you which words it matched and which it didn't
    # report inaccurate search button will send me an email with the search terms and results
    
  end
end
