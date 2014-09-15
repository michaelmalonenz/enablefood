class MakeCostOfOrderNotNull < ActiveRecord::Migration
  def change
     Order.where(cost: nil).each do |o|
        o.cost = 0
     end
     change_column :orders, :cost, :decimal, :null => false, :default => 0
  end
end
