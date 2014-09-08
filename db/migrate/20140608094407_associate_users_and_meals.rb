class AssociateUsersAndMeals < ActiveRecord::Migration
  def change
    create_table :meals_users, :id => false do |t|
      t.belongs_to :meal
      t.belongs_to :user
    end
  end
end
