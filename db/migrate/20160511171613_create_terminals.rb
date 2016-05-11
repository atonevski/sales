class CreateTerminals < ActiveRecord::Migration
  def change
    create_table :terminals do |t|
      t.string :name
      t.string :city
      t.string :address
      t.string :tel
      t.decimal :lat, precision: 12, scale: 9
      t.decimal :lng, precision: 12, scale: 9
      t.references :agent, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
