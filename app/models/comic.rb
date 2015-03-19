class Comic < ActiveRecord::Base
  has_many :comic_tags
  has_many :tags, through: :comic_tags

  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end
end
