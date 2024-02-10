module SpreeRequestForQuotation
  module Admin
    module MainMenu
      class BulkOrderBuilder
        include ::Spree::Core::Engine.routes.url_helpers
        def build
          item = ::Spree::Admin::MainMenu::ItemBuilder.new('quotation_requests', admin_variant_quotation_requests_path).
                   with_availability_check(->(ability, _store) { ability.can?(:manage, ::Spree::VariantQuotationRequest) && ability.can?(:index, ::Spree::VariantQuotationRequest) }).
                   with_label_translation_key('quotation_requests').
                   with_match_path('/quotation_requests').
                   build
          ::Spree::Admin::MainMenu::SectionBuilder.new('quotations', 'cart.svg').
            with_label_translation_key('quotations').
            with_item(item).
            build
        end
      end
    end
  end
end
