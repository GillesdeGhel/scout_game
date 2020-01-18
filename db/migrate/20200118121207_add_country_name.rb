class AddCountryName < ActiveRecord::Migration[5.2]
  def change
    add_column :troops, :country_name, :string
  end
end
