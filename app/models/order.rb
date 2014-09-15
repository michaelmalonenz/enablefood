class Order < ActiveRecord::Base
  belongs_to :meal
  belongs_to :user

  def initialize(params)
    super(params)
    self.cost ||= 0.0
  end

  def update(params)
    params[:cost] = 0.0 if params[:cost] == ''
    super(params)
  end
end
