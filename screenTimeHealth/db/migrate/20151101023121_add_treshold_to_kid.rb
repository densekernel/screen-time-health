class AddTresholdToKid < ActiveRecord::Migration
  def change
    add_column :kids, :threshold, :int
  end
end
