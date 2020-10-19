class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  def complete!
    update_attributes({state: "complete"})
  end

  def close!
    ActiveRecord::Base.transaction do
      self.order.complete!
      self.complete!
    end
  end
end


 

    