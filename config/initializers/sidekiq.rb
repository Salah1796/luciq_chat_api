require 'sidekiq-scheduler'

redis_url = "redis://#{ENV.fetch('REDIS_HOST', 'localhost')}:#{ENV.fetch('REDIS_PORT', 6379)}/0"

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }

  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(Rails.root.join('config/sidekiq.yml'))[:schedule]
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
