require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module NominiReserve
  class Application < Rails::Application
    config.load_defaults 5.1
    config.time_zone = 'Asia/Tokyo'
    config.i18n.default_locale = :ja

    config.paths.add 'lib', eager_load: true

    config.generators do |g|
      g.test_framework       :rspec, view_specs: false, helper_specs: false, fixture: true
      g.helper               false
      g.stylesheets          false
      g.javascripts          false
      g.fixture_replacement  :factory_girl, dir: "spec/support/factories"
    end

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      %Q(#{html_tag}).html_safe
    end
  end
end
