class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :date
      t.decimal :sales, precision: 12, scale: 2
      t.decimal :payout, precision: 12, scale: 2
      t.references :terminal, index: true, foreign_key: true
      t.references :agent, index: true, foreign_key: true
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
