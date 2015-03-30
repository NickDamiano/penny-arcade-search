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
    # also have number of results - so if you type in dick joke it will say 210 results - fart joke too
    # after i build it out, lock down the database or make a back up copy, then PA can use the code to 
    # have people who work for them go through and label comics for their own search. or give them the
    # database tables
  end

  def results
    search_terms_complete  = params[:searcher]
    individual_words = search_terms_complete.split(' ')
    # comics stores an array of hashes - where each hash
    # contains the record information about comics matching
    # the tags
    @comics = []
    individual_words.each do |word|
      word.downcase
      tag = Tag.find_by(tagname: word)
      if tag
        @comics.push(tag.comics)
      end
    end
    tag = Tag.find_by(tagname: search_terms_complete)
    @comics.push(tag.comics)
    @comics.uniq! 
  end
end
