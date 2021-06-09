Datadog.configure do |c|
  c.use :rails, service_name: 'chronos-rails'
end

# Ignore health check logs
# https://github.com/linqueta/rails-healthcheck#ignoring-logs
filter = Datadog::Pipeline::SpanFilter.new do |span|
  span.name == 'rack.request' && span.get_tag('http.url') == Healthcheck.configuration.route
end

Datadog::Pipeline.before_flush(filter)
