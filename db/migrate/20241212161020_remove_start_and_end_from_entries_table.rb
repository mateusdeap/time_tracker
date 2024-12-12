class RemoveStartAndEndFromEntriesTable < ActiveRecord::Migration[8.0]
  def change
    change_table(:entries) do |t|
      t.remove :start
      t.remove :end
    end
  end
end
