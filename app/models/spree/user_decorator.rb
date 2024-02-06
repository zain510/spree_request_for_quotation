module Spree::UserDecorator
  
  def self.prepended(base)
    base.has_many :variant_quotation_requests, dependent: :destroy
  end
  
end
Spree::User.prepend Spree::UserDecorator
