data = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]['redis']
host = data['host']
port = data['port'] || 6379
db = data['db'] || 0

Sidekiq.options[:poll_interval] = 10

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}/#{db}"  }
  schedule_file = "config/schedule.yml"
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}/#{db}"  }
end