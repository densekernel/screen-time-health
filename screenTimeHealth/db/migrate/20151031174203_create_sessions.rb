class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :startTime
      t.datetime :endTime

      t.timestamps null: false
    end
  end
end
