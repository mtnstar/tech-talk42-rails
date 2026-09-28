require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  config.cache_store = :memory_store
  config.action_controller.perform_caching = false

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load

  # Zeigt im Log, welche Codezeile eine Query ausgelöst hat. Perfekt für die N+1-Übung.
  config.active_record.verbose_query_logs = true
  config.active_record.query_log_tags_enabled = true

  config.action_view.annotate_rendered_view_with_filenames = true

  # Für GitHub Codespaces und Docker: beliebige Hosts erlauben (nur lokal!)
  config.hosts.clear
  config.action_controller.forgery_protection_origin_check = false
end
