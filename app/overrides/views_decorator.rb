Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_form_to_product_page',
  insert_after: '[data-hook="product_right_part_wrap"]',
  partial: 'spree/products/bulk_enquiry_form'
)
