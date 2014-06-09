class AssociateUsersAndMeals < ActiveRecord::Migration
  def change
    create_table :meals_users, :id => false do |t|
      t.belongs_to :meals
      t.belongs_to :users
    end
  end
end
