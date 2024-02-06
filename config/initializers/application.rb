# require_relative 'boot'

require 'rails/all'
require_relative '../../app/models/spree_request_for_quotation/configuration.rb'
Bundler.require(*Rails.groups)

module SpreeStarter
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/models)
    config.eager_load = true
  end
end
