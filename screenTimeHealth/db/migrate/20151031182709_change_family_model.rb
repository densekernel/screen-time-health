class ChangeFamilyModel < ActiveRecord::Migration
  def change
    add_column :families, :surname, :string
  end
end
