module Spree
  class VariantQuotationRequest < Spree::Base
    enum status: { new: 0, in_conversation: 1, closed: 2 }, _prefix: :status

    belongs_to :variant
    belongs_to :user
  end
end
