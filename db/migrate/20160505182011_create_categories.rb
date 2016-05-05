class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :category
      t.integer :count
      t.decimal :amount, precision: 10, scale: 2
      t.text :desc
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
