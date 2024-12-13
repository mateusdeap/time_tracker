class Entry < ApplicationRecord
  def time_elapsed
    return if stop.nil?

    (stop - start) % 60
  end
end
