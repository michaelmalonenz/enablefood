# encoding: utf-8
class Meal < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :orders
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

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

  def close_orders
    transaction do
      self.orders_closed = true
      orders.each do |o|
        if o.empty?
          orders.delete(o)
        end
      end
    end
    generate_summary!
    save()
  end

  def generate_summary!
    same_orders = {}
    orders.each do |o|
      next if o.description.blank?
      key = o.description.downcase
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
