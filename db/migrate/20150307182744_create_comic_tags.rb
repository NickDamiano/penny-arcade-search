class CreateComicTags < ActiveRecord::Migration
  def change
    create_table :comic_tags do |t|

      t.timestamps null: false
    end
  end
end
