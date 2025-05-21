class Entry < ApplicationRecord
  serialize :timers, type: Array, coder: YAML, yaml: { permitted_classes: [ Symbol, DateTime, Time, Rational ] }

  before_create :initialize_timers_array

  def running?
    timers.last.has_key?(:start)
  end

  def initialize_timers_array
    self.timers = []
    self.timers << { start: Time.now.to_i }
  end

  def elapsed_time_in_seconds
    total_seconds = 0

    timers.each_slice(2) do |pair|
      if pair.size == 1
        total_seconds += Time.now.to_i - pair[0][:start]
      else
        total_seconds += pair[1][:stop] - pair[0][:start]
      end
    end

    total_seconds
  end

  def start
    timers.first[:start]
  end

  def last_stop_time
    return 0 if running?

    timers.last[:stop]
  end

  def start_timer
    return if running?

    timers << { start: Time.now.to_i }
  end

  def stop_timer(stop_time)
    return unless running?

    timers << { stop: stop_time }
  end
end
