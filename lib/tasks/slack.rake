namespace :slack do
  desc "Send notification to Slack"
  task notification: :environment do
    webhook_url = Rails.application.credentials.slack.dig(:webhook, :chronos_rails)
    notifier = Slack::Notifier.new webhook_url
    notifier.ping "Send message from copilot scheduled job"
    Rails.logger.info('Send slack message successful')
  rescue => e
    Rails.logger.error("Send slack message Error: #{e.backtrace.join("\n")}")
  end
end
