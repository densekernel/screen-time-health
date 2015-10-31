class AddForeignKeyToSessions < ActiveRecord::Migration
  def change
    add_foreign_key :sessions, :kids
  end
end
