class AddAmountToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :amount, :integer
  end
end
