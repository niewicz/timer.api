class ReportMailer < ApplicationMailer

  def report_email(client, start_time = nil, end_time = nil)
    fail unless client.present?

    Time.zone = client.user.timezone
    @client = client

    @start_time = start_time || Time.zone.now.beginning_of_month - 1.month
    @end_time = end_time || @start_time.end_of_month
     
    @time_entries = @client.time_entries
      .where('end_at IS NOT NULL')
      .where('start_at >= ? AND start_at <= ? OR end_at >= ? AND end_at <= ? OR start_at < ? AND end_at > ?', 
        @start_time, @end_time, @start_time, @end_time, @start_time, @end_time
      ).map do |te| 
        if te.start_at >= @start_time && te.end_at <= @end_time
          te
        elsif te.start_at >= @start_time && te.end_at > @end_time
          TimeEntry.new(start_at: te.start_at, end_at: @end_time, task_id: te.task_id)
        elsif te.start_at < @start_time && te.end_at < @end_time
          TimeEntry.new(start_at: @start_time, end_at: te.end_at, task_id: te.task_id)
        else
          TimeEntry.new(start_at: @start_time, end_at: @end_time, task_id: te.task_id)
        end
      end
      
    @total_time = @time_entries.map{ |te| te.total_time }.reduce(:+)

    mail(
      from: "#{@client.user.billing_profile.person_name} by Timer <#{Figaro.env.report_mailer_email}>",
      to: "#{@client.contact_person_name.presence || @client.name} <#{@client.contact_person_email.presence || @client.email}>",
      subject: "Report for #{(@start_time).strftime('%B')}",
      template_path: 'mailers/report_mailer'
    )
  end

end