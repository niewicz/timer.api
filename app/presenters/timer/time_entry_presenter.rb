class Timer::TimeEntryPresenter < Timer::BasePresenter

  def task
    return unless object.task.present?
    object.task
  end

  def project
    return object.task.project if object.task.present? && object.task.project.present?
    return object.project if object.project.present?
    return
  end

  def client
    return unless object.task.present? && object.task.project.present? && object.task.project.client.present?
    object.task.project.client
  end

end