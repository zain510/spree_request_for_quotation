module Spree::VariantDecorator
  
  def self.prepended(base)
    base.has_many :variant_quotation_requests, dependent: :destroy
  end
  
end
Spree::Variant.prepend Spree::VariantDecorator
