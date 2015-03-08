class AddIdsToComicTags < ActiveRecord::Migration
  def change
    change_table :comic_tags do |t|
      t.references :tag, index: true
      t.references :comic, index: true
    end
  end
end
