class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :description
      t.float :average_price

      t.timestamps
    end
  end
end
