# app/controllers/orders_controller.rb
class Spree::OrdersController < ApplicationController
  before_action :validate_payment_method_exists

  def create
    variant_sku = params[:variant_sku]
    user_id = params[:user_id]
    quantity = params[:quantity]
    price = params[:price]
    variant = Spree::Variant.find_by(sku: variant_sku)
    user = Spree::User.find(user_id)
    address = user.addresses.first
    order = Spree::Order.new(item_total: price, total: price, currency: variant.cost_currency, user_id: user.id, state: 'cart', shipment_state:'pending', payment_state: 'balance_due', item_count: quantity, bill_address_id: address.id, ship_address_id: address.id, vendor_id: (variant.vendor_id || variant.product.vendor_id))
    order.line_items.new(variant_id: variant.id, quantity: quantity, price: price, currency: variant.cost_currency, cost_price: price)
    order.shipments.new(address_id: address.id, state: 'pending', stock_location_id: variant.stock_locations&.first&.id)
    # Set payment method to Cash on Delivery
    # payment_method = Spree::PaymentMethod.find_by(name: 'Cash on Delivery')
    payment = order.payments.build(payment_method: payment_method)
    payment.amount = order.total
    payment.save!

    begin
      order.save!
      ['delivery', 'payment', 'confirm'].each do |state|
        order.update(state: state)
      end
      order.update(state: 'complete', completed_at: Time.now )
      update_variant_quotation_request
      redirect_to variant_quotation_requests_path, notice: 'Order created successfully!'
    rescue ActiveRecord::RecordInvalid => e
      redirect_back(fallback_location: root_path, alert: e.message)
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
