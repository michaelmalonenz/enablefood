class Meal < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :orders

  def total_cost
    total = 0.0
    orders.each do |o|
      total += o.cost
    end
    return total
  end
end
