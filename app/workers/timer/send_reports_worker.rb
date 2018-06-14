class Timer::SendReportsWorker
  include Sidekiq::Worker

  def perform
    p '----'
    p ::Client.where(auto_send: true)
  end
end