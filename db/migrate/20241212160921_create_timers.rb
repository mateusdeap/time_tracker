class CreateTimers < ActiveRecord::Migration[8.0]
  def change
    create_table :timers do |t|
      t.datetime :start
      t.datetime :end
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
