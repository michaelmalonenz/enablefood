class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :meals
  has_many :orders

  after_create :add_orders

  private
  def add_orders
    Meal.where(orders_closed: nil).each do |m|
      m.users << self
      m.orders.create(:user => self, :meal => m)
    end
  end

end
