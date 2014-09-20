class AddSummaryToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :summary, :text
  end
end
