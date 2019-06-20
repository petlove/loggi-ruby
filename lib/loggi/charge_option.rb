# frozen_string_literal: true

module Loggi
  class ChargeOption
    attr_accessor :label

    def initialize(options)
      @label = options[:label]
    end

    class << self
      def by_method(method)
        case method
        when 1 then 'Cartão de crédito'
        when 2 then 'Cartão de débito'
        when 4 then 'Dinheiro sem troco'
        when 5 then 'Dinheiro com troco'
        when 16 then 'Cheque'
        when 32 then 'Pagamento com maquininha da loja'
        when 64 then 'Pagamento já realizado'
        when 128 then 'Vale-Refeição'
        when 256 then 'Sodexo'
        when 512 then 'Alelo'
        when 1024 then 'Ticket'
        end
      end
    end
  end
end
