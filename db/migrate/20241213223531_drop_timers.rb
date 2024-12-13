class DropTimers < ActiveRecord::Migration[8.0]
  def change
    drop_table(:timers, if_exists: true)
  end
end
