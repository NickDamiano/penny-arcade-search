class Tag < ActiveRecord::Base
  has_many :comic_tags
  has_many :comics, through: :comic_tags
  validates :tagname, uniqueness: true
end

