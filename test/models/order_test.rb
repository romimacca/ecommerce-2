require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  # test 'creates a random number on create' do
  #   user = User.create(email: "user@example.com", password: "12345678")
  #   order = Order.create(user_id: user.id)
  #   assert !order.number.nil?
  # end

  # test 'number must be unique' do
  #   user = User.create(email: "user@example.com", password: "12345678")
  #   order = Order.create(user_id: user.id)
  #   duplicated_order = order.dup
  #   assert_not duplicated_order.valid?
  # end

  # test 'add products as order_items' do
  #   user = User.create(email: "user@example.com", password: "12345678")
  #   order = Order.create(user_id: user.id)

  #   product = Product.create(name: "test", price: 1, stock: 10, sku: "001")
  #   order.add_product(product.id, 1)

  #   assert_equal order.order_items.count, 1
  # end

  # test 'products with stock zero cant be added to cart' do
  #   user = User.create(email: "user@example.com", password: "12345678")
  #   order = Order.create(user_id: user.id)

  #   product = Product.create(name: "test", price: 1, stock: 0, sku: "001")
  #   order.add_product(product.id, 1)

  #   assert_equal order.order_items.count, 0
  # end

  test 'pass total price to cents' do
    user_test = User.create(email: "user@me.cl", password: "123123")
    order = Order.create(user: user_test, total: 100)

    assert_equal order.total_cents, 10000
    # No me toma .total_cents
  end

  test 'order creates a payment' do
    user_test = User.create(email: "user@me.cl", password: "123123")
    order = Order.create(user: user_test, total: 100)

    PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    order.create_payment("PEC", "token_123456789" )
    
    assert_equal order.payments.last.state, "processing"

    # no me toma .payments ni .create_payment
  end

  test 'order is marked as complete' do
    user_test = User.create(email: "user@me.cl", password: "123123")
    order = Order.create(user: user_test, total: 100)
    
    order.complete!
    assert_equal order.state, "completed"

    # no toma .complete! ni .state
  end
end
