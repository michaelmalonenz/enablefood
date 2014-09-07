class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :meals
  has_many :orders
  #belongs_to :owner, :class_name => 'Meal', :foreign_key => 'meal_id'
end
