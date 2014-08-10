class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :cost
      t.string :description
      t.references :meal, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
