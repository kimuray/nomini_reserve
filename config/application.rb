require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module NominiReserve
  class Application < Rails::Application
    config.load_defaults 5.1
    config.time_zone = 'Asia/Tokyo'
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.test_framework       :rspec, view_specs: false, helper_specs: false, fixture: true
      g.helper               false
      g.stylesheets          false
      g.javascripts          false
      g.fixture_replacement  :factory_girl, dir: "spec/support/factories"
    end
  end
end
