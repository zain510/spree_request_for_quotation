Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_form_to_product_page',
  insert_after: '[data-hook="product_right_part_wrap"]',
  partial: 'spree/products/bulk_enquiry_form'
)

Deface::Override.new(
  virtual_path: 'spree/users/show',
  name: 'add_form_to_product_page',
  insert_before: '[data-hook="account_my_orders"]',
  partial: 'spree/variant_quotation_requests/my_quotation_requests'
)
