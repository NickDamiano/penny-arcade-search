class ComicTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :comic
  validates :tag_id, :uniqueness => { scope: :comic_id }
  validates :tag_id, :comic_id, presence: true


  def self.save_tags(tags, comic)
    split_tags = tags.split(',').map{ |tag| tag.strip.downcase }
    split_tags.each do |tag|
      tagname = Tag.create(tagname: tag)
      ComicTag.create(tag_id: tagname.id, comic_id: comic)
    end
  end
end
