class Entry < ApplicationRecord
  serialize :timers, type: Array, coder: YAML, yaml: { permitted_classes: [ Symbol, DateTime, Time ] }

  before_create :initialize_timers_array

  def running?
    timers.last.has_key?(:start)
  end

  def initialize_timers_array
    timers << { start: DateTime.now }
  end

  def elapsed_time_in_seconds
    total_seconds = 0

    timers.each_slice(2) do |pair|
      if pair.size == 1
        total_seconds += DateTime.now.to_i - pair[0][:start].to_i
      else
        total_seconds += pair[1][:stop].to_i - pair[0][:start].to_i
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
end
