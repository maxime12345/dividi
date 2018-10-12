require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dividi
  class Application < Rails::Application

    #before installing rspec
    # config.generators do |generate|
    #       generate.assets false
    #       generate.helper false
    #       generate.test_framework  :test_unit, fixture: false
    # end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
<<<<<<< HEAD
    config.i18n.default_locale = :en
=======
    config.i18n.default_locale = :fr
>>>>>>> 73a705fa08939c3c5b9982109830ce384e249d72
  end
end
