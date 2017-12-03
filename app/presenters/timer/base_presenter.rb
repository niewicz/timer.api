class Timer::BasePresenter

  def initialize(object)
    @object = object.presence || fail(ArgumentError)
  end

  private

  def object
    @object
  end

end