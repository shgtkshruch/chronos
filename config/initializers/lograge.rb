Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.ignore_actions = [Healthcheck::CONTROLLER_ACTION]

  # 現在のスレッドのトレース情報を取得
  correlation = Datadog.tracer.active_correlation
  config.lograge.custom_options = lambda do |event|
    {
      ip: event.payload[:ip],
      # https://docs.datadoghq.com/ja/tracing/connect_logs_and_traces/ruby/
      dd: {
        trace_id: correlation.trace_id.to_s,
        span_id: correlation.span_id.to_s,
        env: correlation.env.to_s,
        service: correlation.service.to_s,
        version: correlation.version.to_s
      },
      ddsource: ["ruby"],
      params: event.payload[:params]
    }
  end

  # Exclude heathcheck logs from rails logs
  # https://github.com/linqueta/rails-healthcheck#ignoring-logs
  config.lograge.ignore_actions = [Healthcheck::CONTROLLER_ACTION]
end
