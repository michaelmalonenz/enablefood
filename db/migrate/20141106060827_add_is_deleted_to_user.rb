class AddIsDeletedToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_deleted, :boolean, :default => false, :null => false
    User.all.each {|user| user.is_deleted = false }
  end
end
