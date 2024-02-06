module Spree
  class VariantQuotationRequestsController < Spree::StoreController
    def create
      @variant_quotation_request = try_spree_current_user.variant_quotation_requests.new(variant_quotation_request_params)

      @variant_quotation_request.save
      
      respond_to do |format|
        format.js
        format.html
      end

    end

    private

    def variant_quotation_request_params
      params.require(:variant_quotation_request).permit(:variant_id, :quantity, :price, :status)
    end
  end
end
