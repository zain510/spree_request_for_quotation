# app/mailers/quotation_accepted_mailer.rb
module Spree
  class QuotationAcceptedMailer < ::Spree::BaseMailer
    def send_quotation_accepted_email(user, variant_sku, spree_admin_email)
      @user = user
      @variant_sku = variant_sku
      @spree_admin_email = spree_admin_email
      mail(to: @user.email, subject: "Your Quotation Accepted")
    end
  end
end
