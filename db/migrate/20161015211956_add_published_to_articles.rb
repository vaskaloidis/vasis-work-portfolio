class AddPublishedToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :published, :boolean, null: true
  end
end
