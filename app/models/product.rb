class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  
  has_many :variants

  # has_many :order_items
  # has_many :orders, through: :order_items

  def visible_on_catalog?
    contador = 0
    self.variants.each do |v|
      contador += v.stock
    end

    (contador > 0) ? false : true
  end
end
