class RemoveUsersFromMeal < ActiveRecord::Migration
  def change
    change_table :meals do |t|
      t.remove :users_id
    end
  end
end
