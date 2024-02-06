module Spree
  module Admin
    class VariantQuotationRequestsController < ResourceController
      before_action :update_status, only: [:create, :update]

      def index
        @open_variant_quotation_requests = Spree::VariantQuotationRequest.includes(:user, :variant).where(status: ['new', 'in_conversation']).page(params[:page]).per(params[:per_page]).sort_by(&:status)
        @closed_variant_quotation_requests = Spree::VariantQuotationRequest.includes(:user, :variant).where(status: ['closed']).page(params[:page]).per(params[:per_page])
      end

      private

      def find_resource
        Spree::VariantQuotationRequest.find(params[:id])
      end

      def update_status
        status = params[:variant_quotation_request][:status]
        case status
        when 'New'
          params[:variant_quotation_request][:status] = 0
        when 'In Conversation'
          params[:variant_quotation_request][:status] = 1
        when 'Closed'
          params[:variant_quotation_request][:status] = 2
        end
      end

      def collection
        params[:q] = {} if params[:q].blank?
        variant_quotation_requests = super.order(priority: :asc)
        @search = variant_quotation_requests.ransack(params[:q])
        @collection = @search.result.
            page(params[:page]).
            per(params[:per_page])
      end
    end
  end
end
