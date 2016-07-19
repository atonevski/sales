class CreateCommissionLetters < ActiveRecord::Migration
  def change
    create_table :commission_letters do |t|
      t.boolean :invoiced_correctly
      t.decimal :incorrect_sum, precision: 12, scale: 2
      t.date :invoice_date
      t.references :user, index: true, foreign_key: true
      t.references :agent, index: true, foreign_key: true
      t.string :from
      t.string :to

      t.timestamps null: false
    end
  end
end
