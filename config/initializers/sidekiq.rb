if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = {url: ENV['REDIS_URL']}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: ENV['REDIS_URL']}
  end
else
  reds_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
  Sidekiq.configure_server do |config|
    config.redis = {url: reds_url, namespace: 'kaopass_sidekiq'}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: reds_url, namespace: 'kaopass_sidekiq'}
  end
end
