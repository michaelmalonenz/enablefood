class AddPaymentDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :payment_details, :string
  end
end
