class AddVendorIdToSpreeVariantQuotationRequests < SpreeExtension::Migration[4.2]
  def change
    add_reference :spree_variant_quotation_requests, :vendor, index: true
  end
end
