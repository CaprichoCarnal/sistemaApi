require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Example
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Habilitar la protección CSRF
    config.action_controller.default_protect_from_forgery = true
    
     # Configuración de CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # Permitir solicitudes desde cualquier origen. Cambia '*' por los orígenes permitidos según tus necesidades.
        resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
      end
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
