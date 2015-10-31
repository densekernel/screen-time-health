class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string   :name
      t.string   :unique_token
      t.references :family, index: true

      t.timestamps null: false
    end
  end
end
