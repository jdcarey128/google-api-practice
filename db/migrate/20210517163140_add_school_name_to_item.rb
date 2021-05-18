class AddSchoolNameToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :school, :string
  end
end
