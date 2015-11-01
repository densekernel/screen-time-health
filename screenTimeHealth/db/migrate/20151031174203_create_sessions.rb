class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :starttime
      t.datetime :endtime
      t.references :kids, index: true

      t.timestamps null: false
    end
  end
end
