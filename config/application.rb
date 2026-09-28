require_relative "boot"

require "rails"
# Nur die Teile von Rails, die wir brauchen.
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Gipfelbuch
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Bern"
    config.i18n.default_locale = :en

    config.generators do |g|
      g.system_tests = nil
      g.helper = false
      g.stylesheets = false
    end
  end
end
