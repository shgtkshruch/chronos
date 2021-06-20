Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new

  ## Disables log coloration
  config.colorize_logging = false

  # Exclude heathcheck logs from rails logs
  # https://github.com/linqueta/rails-healthcheck#ignoring-logs
  config.lograge.ignore_actions = [Healthcheck::CONTROLLER_ACTION]

  config.lograge.custom_payload do |controller|
    {
      request_id: controller.request.request_id
    }
  end


  # 現在のスレッドのトレース情報を取得
  # https://docs.datadoghq.com/ja/tracing/connect_logs_and_traces/ruby/#ruby-%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AB%E3%83%AD%E3%82%AE%E3%83%B3%E3%82%B0%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88
  config.lograge.custom_options = lambda do |event|
    correlation = Datadog.tracer.active_correlation
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
      ddsource: "ruby",
      params: event.payload[:params]
    }
  end
end
