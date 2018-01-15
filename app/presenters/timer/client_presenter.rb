class Timer::TimeEntryPresenter < Timer::BasePresenter

  def last_projects
    object.projects.order(created_at: :desc).limit(10).map do |p|
      {
        id: p.id,
        title: p.title,
        total_time: p.total_time,
        total_tasks: p.total_tasks
      }
    end
  end

  def total_time
   p 'to implement'
  end

  def total_money_earned
    p 'to implement'
  end

end