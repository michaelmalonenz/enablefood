# encoding: utf-8
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

  def total_owing
    owing = 0.0
    orders.each do |o|
      owing += o.cost unless o.has_paid?
    end
    return owing
  end

  def generate_summary!
    same_orders = {}
    orders.each do |o|
      key = o.description.nil? ? nil : o.description.downcase
      same_orders[key] ||= {:actual => nil, :count => 0}
      same_orders[key][:count] += 1
      same_orders[key][:actual] ||= o.description
    end
    self.summary = ''
    same_orders.keys.sort.each do |k|
      self.summary += "#{same_orders[k][:actual]} ✕#{same_orders[k][:count]}\n"
    end
  end
end
