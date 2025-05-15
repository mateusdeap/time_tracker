module EntriesHelper
  def timer_button_data_action(entry)
    return "timer#stop" if entry.running?

    "timer#start"
  end

  def timer_button_action(entry)
    return "Stop" if entry.running?

    "Start"
  end

  def formatted_elapsed_time(entry)
    formatted = []
    total_seconds = entry.elapsed_time_in_seconds
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60

    formatted << formatted_time(hours)
    formatted << formatted_time(minutes)
    formatted << formatted_time(seconds)

    formatted.join(":")
  end

  def formatted_time(time)
    return "00" if time == 0

    sprintf "%02d", time
  end

  def end_time(entry)
    return "" if entry.last_stop_time == 0

    entry.last_stop_time.to_fs(:full_time)
  end
end
