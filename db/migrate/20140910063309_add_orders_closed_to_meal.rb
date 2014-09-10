class AddOrdersClosedToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :orders_closed, :boolean
  end
end
