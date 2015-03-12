class Tag < ActiveRecord::Base
  has_many :comic_tags
  has_many :comics, through: :comic_tags
end

fart = Tag.create()
p fart.id
