class RemoveStartAndStopFromEntries < ActiveRecord::Migration[8.0]
  def change
    change_table(:entries) do |t|
      t.remove :start
      t.remove :stop
    end
  end
end
