Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new

  # Exclude heathcheck logs from rails logs
  # https://github.com/linqueta/rails-healthcheck#ignoring-logs
  config.lograge.ignore_actions = [Healthcheck::CONTROLLER_ACTION]
end
