class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :name
      t.string  :type
      t.text    :desc
      t.integer :parent
      t.decimal :price, precision: 6, scale: 2
      t.integer :volume
      t.decimal :commission, precision: 4, scale: 3

      t.timestamps null: false
    end
  end
end
