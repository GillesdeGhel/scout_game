Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  config.assets.debug = true
  config.assets.digest = true
  config.assets.quiet = true
  config.assets.raise_runtime_errors = true

  Rails.application.routes.default_url_options = { host: 'localhost', port: 8080 }
  config.action_mailer.default_url_options = { host: 'localhost', port: 8080 }
  config.action_mailer.asset_host = 'http://localhost:8080'

  config.back_office_url = 'http://localhost:8080'
  config.checkup_front_endpoint = 'http://localhost:8080/#/'
end
