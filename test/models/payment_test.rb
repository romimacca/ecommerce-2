require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test 'payment is marked as complete' do
    user_test = User.create(email: "user@me.cl", password: "123123")
    order = Order.create(user: user_test, total: 100)

    pm = PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    payment = Payment.create(order_id: order.id, payment_method_id: pm.id, state: "processing", total: 100, token: "token_123456789")
    payment.complete!
    
    assert_equal payment.state, "completed"
  end

  test 'complete payment' do
    user_test = User.create(email: "user@me.cl", password: "123123")
    order = Order.create(user: user_test, total: 100)

    pm = PaymentMethod.create(name: "Paypal Express Checkout", code: "PEC")
    payment = Payment.create(order_id: order.id, payment_method_id: pm.id, state: "processing", total: 100, token: "token_123456789")

    paymant.close!

    assert_equal payment.state, "completed"
    assert_equal payment.order.state, "completed"

  end

end
