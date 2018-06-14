require 'redis'

SCHEDULE_FILE = 'config/sidekiq_schedule.yml'

if Figaro.env.redis_server_host? && Figaro.env.redis_server_port? && Figaro.env.redis_db_app?
  puts 'Initializing Redis!'
  $redis = Redis.new(
    host: Figaro.env.redis_server_host,
    port: Figaro.env.redis_server_port,
    db: Figaro.env.redis_db_app,
  )

  sidekiq_redis_url = "redis://#{Figaro.env.redis_server_host}:#{Figaro.env.redis_server_port}/#{Figaro.env.redis_db_sidekiq}"
  puts "Sidekiq redis url: #{sidekiq_redis_url}"
  
  Sidekiq.configure_server do |config|
    config.redis = {url: sidekiq_redis_url, network_timeout: 5}
    config.options[:concurrency] = Figaro.env.sidekiq_conf_concurrency.to_i || 10
    config.average_scheduled_poll_interval = 5
  end
  
  Sidekiq.configure_client do |config|
    config.redis = {url: sidekiq_redis_url, network_timeout: 5}
  end
end

if File.exist?(SCHEDULE_FILE) && Sidekiq.server?
  puts "Initializing scheduled jobs from #{SCHEDULE_FILE}!"
  puts YAML.load_file(SCHEDULE_FILE)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(SCHEDULE_FILE)
end