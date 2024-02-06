Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.insert_before('users', ::SpreeRequestForQuotation::Admin::MainMenu::BulkOrderBuilder.new.build)
    Rails.application.config.spree_backend.tabs[:variant_quotations] = ::SpreeRequestForQuotation::Admin::Tabs::QuotationsTabsBuilder.new.build
  end
end
