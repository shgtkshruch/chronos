Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_options = lambda do |event|
    {
      ip: event.payload[:ip],
      params: event.payload[:params]
    }
  end
end
