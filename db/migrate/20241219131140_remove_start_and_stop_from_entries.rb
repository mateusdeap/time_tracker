class RemoveStartAndStopFromEntries < ActiveRecord::Migration[8.0]
  def change
    change_table(:entries) do |t|
      t.remove :start, type: :datetime
      t.remove :stop, type: :datetime
    end
  end
end
