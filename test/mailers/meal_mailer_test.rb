require 'test_helper'

class MealMailerTest < ActionMailer::TestCase
  test 'creation created' do
    MealMailer.creation_email(meals(:meal_one), 'http://someurl.com').deliver
    assert_not ActionMailer::Base.deliveries.empty?
  end

  test 'creation layout' do
    email = MealMailer.creation_email(meals(:meal_one), 'http://someurl.com')
    assert_match /<head>/, email.body.to_s
  end

  test 'orders closed payment details' do
    email = MealMailer.orders_closed_email(meals(:meal_one), orders(:order_two))
    assert_match 'This is now payable to', email.body.to_s
  end

  test 'orders closed no payment details' do
    email = MealMailer.orders_closed_email(meals(:meal_two), orders(:order_five))
    assert_no_match 'This is now payable to', email.body.to_s
  end
end
