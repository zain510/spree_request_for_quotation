module Spree
  class VariantQuotationRequestsController < Spree::StoreController
    before_action :find_resource, only: [:edit, :update]
    before_action :update_status, only: [:update]

    def create
      @variant_quotation_request = try_spree_current_user.variant_quotation_requests.new(variant_quotation_request_params)
      @variant_quotation_request.save
      
      respond_to do |format|
        format.js
        format.html
      end
    end

    def update
      if @variant_quotation_request.update!(variant_quotation_request_params)
        redirect_to variant_quotation_requests_path, notice: "Variant Quotation Request was successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def index
      @closed_variant_quotation_requests = spree_current_user.variant_quotation_requests.includes(:user, :variant).order(updated_at: :desc).where(status: ['closed']).page(params[:page]).per(params[:per_page])
      @open_variant_quotation_requests = spree_current_user.variant_quotation_requests.includes(:user, :variant).order(updated_at: :desc).where(status: ['new', 'in_conversation']).page(params[:page]).per(params[:per_page])
    end

    def edit
    end

    private

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

    def find_resource
      @variant_quotation_request = Spree::VariantQuotationRequest.find(params[:id])
    end

    def collection
      params[:q] = {} if params[:q].blank?
      variant_quotation_requests = super.order(priority: :asc)
      @search = variant_quotation_requests.ransack(params[:q])
      @collection = @search.result.page(params[:page]).per(params[:per_page])
    end

    def variant_quotation_request_params
      params.require(:variant_quotation_request).permit(:variant_id, :quantity, :price, :status)
    end
  end
end
