class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :title
      t.date :date
      t.string :website
      t.references :users, index: true

      t.timestamps
    end
  end
end
