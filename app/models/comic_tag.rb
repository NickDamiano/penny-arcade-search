class ComicTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :comic
end
