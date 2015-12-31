class AddTitleColumnToComic < ActiveRecord::Migration
  def change
  	add_column :comics, :comic_title, :string
  end
end
