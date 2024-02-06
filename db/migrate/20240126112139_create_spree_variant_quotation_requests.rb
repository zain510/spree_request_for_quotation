class CreateSpreeVariantQuotationRequests < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_variant_quotation_requests do |t|
      t.references :variant
      t.references :user
      t.integer :quantity
      t.integer :status, default: 0
      t.decimal :price

      t.timestamps
    end
  end
end
