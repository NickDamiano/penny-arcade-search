class ComicTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :comic
  validates :tag_id, :comic_id, presence: true

  def self.save_tags(tags, comic)
    split_tags = tags.split(',').map{ |tag| tag.strip.downcase }
    split_tags.each do |tag|
      # Creates the tag and saves it - validation rejects duplicates
      binding.pry
      # TODO save title as a tag through the comictag and if tag being iterated through is same as title, do not save it and skip to next iteration.
      Tag.create(tagname: tag)
      tagname = Tag.find_by(tagname: tag)
      # As long as the record doesn't already exist, add it to the database
      unless ComicTag.find_by(tag_id: tagname.id, comic_id: comic)
        ComicTag.create(tag_id: tagname.id, comic_id: comic)
      end
    end
  end
end
