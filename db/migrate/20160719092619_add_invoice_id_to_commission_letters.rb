class AddInvoiceIdToCommissionLetters < ActiveRecord::Migration
  def change
    add_column :commission_letters, :invoice_id, :string
  end
end
