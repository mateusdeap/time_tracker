class AddStartTimeAndStopTimeToEntries < ActiveRecord::Migration[8.0]
  def change
    add_column(:entries, :start, :datetime)
    add_column(:entries, :stop, :datetime)
  end
end
