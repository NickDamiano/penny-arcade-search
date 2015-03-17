class ComicTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :comic

  # get a string with words separated by comma
  # split it into an array, save thet tags into 
  # the database, and then save into the comictag 
  # table to connect tags and comics
  def self.save_tags(tags)
    tags = tags.downcase
    split_tags = tags.split(',')
    p split_tags
    # split_tags.each do |tag|
    #   tagname = Tag.find_by(tagname: tag)
    #   if tagname.nil?
    #     tagname = Tag.create(tagname: tag)
    #   end
    #   p tagname.id
    # end
  end
end
