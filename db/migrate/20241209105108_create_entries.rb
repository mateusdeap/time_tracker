class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.datetime :start
      t.datetime :end
      t.text :project
      t.text :description

      t.timestamps
    end
  end
end
