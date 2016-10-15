class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :code
      t.string :html

      t.timestamps
    end
  end
end
