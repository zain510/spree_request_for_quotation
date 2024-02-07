module Spree
  module Admin
    class VariantQuotationRequestsController < ResourceController
      before_action :update_status, only: [:create, :update]

      def index
        @open_variant_quotation_requests = Spree::VariantQuotationRequest.includes(:user, :variant).where(status: ['new', 'in_conversation']).page(params[:page]).per(params[:per_page]).sort_by(&:status)
        @closed_variant_quotation_requests = Spree::VariantQuotationRequest.includes(:user, :variant).where(status: ['closed']).page(params[:page]).per(params[:per_page])
      end

      def send_quotation_accepted_email
        user = @variant_quotation_request.user
        variant = @variant_quotation_request.variant

        variant_sku = variant.sku
        spree_admin_email = spree_current_user.email
        
        Spree::QuotationAcceptedMailer.send_quotation_accepted_email(user, variant_sku, spree_admin_email).deliver_now
        redirect_to(admin_variant_quotation_requests_path, notice: "Confirmation email for the quotation has been sent successfully.")
      end

      private

      def find_resource
        @variant_quotation_request =  Spree::VariantQuotationRequest.find(params[:id])
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
        @collection = @search.result.page(params[:page]).per(params[:per_page])
      end
    end
  end
end
