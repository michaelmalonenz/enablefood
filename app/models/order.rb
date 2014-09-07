class Order < ActiveRecord::Base
  belongs_to :meal
  belongs_to :user

  def initialize(params)
    super(params)
    self.cost ||= 0.0
  end
end
