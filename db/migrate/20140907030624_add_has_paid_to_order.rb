class AddHasPaidToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :has_paid, :boolean
  end
end
