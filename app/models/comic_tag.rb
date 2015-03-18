class ComicTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :comic

  # add tags to tag
  def self.save_tags(tags, comic)
    tags = tags.downcase
    split_tags = tags.split(',').map{ |tag| tag.strip.downcase }
    p split_tags
    p 'tags'

    # Add new tags to tag database
    split_tags.each do |tag|
      tagname = Tag.find_by(tagname: tag)
      if tagname.nil?
        tagname = Tag.create(tagname: tag)
      end
      p "tagname id is #{tagname.id}" 
      p "comic id is #{comic}"
      ComicTag.create(tag_id: tagname.id, comic_id: comic)
    end
    # Create associated ComicTags

  end
end
