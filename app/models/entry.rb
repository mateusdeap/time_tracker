class Entry < ApplicationRecord
  has_many :timers

  accepts_nested_attributes_for :timers

  def start
    timers.first.start
  end

  def entry_end
    timers.last.end
  end

  def time_elapsed
    return if entry_end.nil?

    entry_end - start
  end
end
