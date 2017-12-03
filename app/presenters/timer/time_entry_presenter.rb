class Timer::TimeEntryPresenter < Timer::BasePresenter

  def task
    return unless object.task.present?
    object.task
  end

  def project
    return unless object.task.present? && object.task.project.present?
    object.task.project
  end

  def client
    return unless object.task.present? && object.task.project.present? && object.task.project.client.present?
    object.task.project.client
  end

end