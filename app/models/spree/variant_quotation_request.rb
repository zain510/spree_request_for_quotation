module Spree
  class VariantQuotationRequest < Spree::Base
    enum status: { new: 0, in_conversation: 1, closed: 2 }, _prefix: :status

    belongs_to :variant
    belongs_to :user

    def confirm_message(user)
      if price.blank?
        "Your quotation is pending admin approval. Once accepted, you'll be able to proceed with placing your order. Thank you for your patience."
      elsif user.addresses.blank?
        "Oops! It seems you haven't saved any address yet. To proceed with placing your order, please make sure to save at least one address."
      else
        "If you wish to proceed with placing your order, please click 'Confirm', and your order will be processed."
      end
    end
  end
end
