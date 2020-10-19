class Coupon < ApplicationRecord
    belongs_to :user, optional: true

    #El cupon esta disponible para usar?
    def self.available?
        valid_on_count?
    end
    
    # Cuantas veces he usado el cupon
    def valid_on_count?
        if kind.eq?('target')
            if count < 0 ? false : true
        else
            true
        end
    end

    #Calculando los totales
    def compute_total(total)
        if discount.eq?('percent')
            percent_value = amount.to_f / 100
            total = total - ( total * percent_value )
        else
            total = total - amount
            (total < 0) ? 0 : total
        end
    end
end

#Controlador antes de pagar
coupon = Coupon.find_by(code: get_code_from_params)
if coupon.available?
    price = coupon.compute_total( order.total )
end

#Controlador despues de pagar
coupon.count += 1
coupon.save!