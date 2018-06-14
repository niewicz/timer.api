class Timer::SendReportsWorker
  include Sidekiq::Worker

  def perform
    clients  = ::Client.where('auto_send = true AND (email IS NOT NULL OR contact_person_email IS NOT NULL)')

    clients.each do |c|
      ReportMailer.report_email(c).deliver_now
    end
  end
end