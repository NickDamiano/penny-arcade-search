class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :page_url
      t.string :img_url
      t.date :publish_date

      t.timestamps null: false
    end
  end
end
