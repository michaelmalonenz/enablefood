class MealMailer < ActionMailer::Base
  default from: 'no-reply@enablefood.com'

  def creation_email(meal, url)
    @meal = meal
    @url = url
    mail(to: @meal.users.collect {|u| u.email }, subject: meal.title)
  end

  def reminder_email(meal)
    @meal = meal
    meal.orders.each do |order|
      if order.empty?
        @user = order.user
        mail(to: order.user.email, subject: "Reminder: #{meal.title}")
      end
    end
  end

  def orders_closed_email(meal, order)
    @meal = meal
    @order = order
    mail(to: order.user.email, subject: "#{@meal.title} orders have been closed")
  end
end
