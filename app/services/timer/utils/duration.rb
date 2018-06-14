module Timer::Utils::Duration

  def self.simple(diff)
    s = diff.to_i
    tmp = s % 60
    seconds = tmp < 10 ? '0' + tmp.to_s : tmp.to_s

    m = (s / 60).floor
    tmp = m % 60
    minutes = tmp < 10 ? '0' + tmp.to_s : tmp.to_s

    h = (m / 60).floor
    tmp = h % 60
    hours = tmp < 10 ? '0' + tmp.to_s : tmp.to_s

    days = (h / 24).floor

    if days > 0
      "#{days}:#{hours}:#{minutes}:#{seconds}"
    else
      "#{hours}:#{minutes}:#{seconds}"
    end
  end

  def self.formatted(diff)
    s = diff.to_i
    tmp = s % 60
    seconds = tmp < 10 ? '0' + tmp.to_s : tmp.to_s

    m = (s / 60).floor
    tmp = m % 60
    minutes = tmp < 10 ? '0' + tmp.to_s : tmp.to_s

    h = (m / 60).floor
    tmp = h % 60
    hours = tmp < 10 ? '0' + tmp.to_s : tmp.to_s

    days = (h / 24).floor

    if days > 0 
      "#{days}d #{hours}h #{minutes}m #{seconds}s"
    elsif hours.to_i > 0
      "#{hours}h #{minutes}m #{seconds}s"
    else
      "#{minutes}m #{seconds}s"
    end
  end

end