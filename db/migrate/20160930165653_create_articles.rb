class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :contet
      t.text :excerpt
      t.text :categories

      t.timestamps
    end
  end
end