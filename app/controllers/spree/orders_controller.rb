# app/controllers/orders_controller.rb
class Spree::OrdersController < ApplicationController
  before_action :validate_payment_method_exists

  def create
    variant_sku = params[:variant_sku]
    user_id = params[:user_id]

    variant = Spree::Variant.find_by(sku: variant_sku)
    user = Spree::User.find(user_id)

    order = Spree::Order.create(user: user)
    order.variant_ids = [variant.id]

    # Set payment method to Cash on Delivery
    # payment_method = Spree::PaymentMethod.find_by(name: 'Cash on Delivery')
    payment = order.payments.build(payment_method: payment_method)
    payment.amount = order.total
    payment.save!

    if order.save
      update_variant_quotation_request
      # Order successfully created
      redirect_to variant_quotation_requests_path, notice: 'Order created successfully!'
    else
      # Handle errors if any
      redirect_back(fallback_location: root_path, alert: 'Failed to create order')
    end
  end

  private

  def payment_method
    @payment_method ||= Spree::PaymentMethod.find_by(name: 'Cash on Delivery')
  end

  def validate_payment_method_exists
    return if payment_method.present?

    redirect_back(fallback_location: root_path, alert: 'Payment Method not found')
  end

  def update_variant_quotation_request
    @variant_quotation_request = Spree::VariantQuotationRequest.find(params[:variant_quotation_request_id])
    @variant_quotation_request.update(status: 2)
  end
end
