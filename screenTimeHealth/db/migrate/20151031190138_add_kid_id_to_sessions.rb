class AddKidIdToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :kid_id, :integer
  end
end
