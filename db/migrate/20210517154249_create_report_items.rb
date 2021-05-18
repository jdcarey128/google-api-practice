class CreateReportItems < ActiveRecord::Migration[5.2]
  def change
    create_table :report_items do |t|
      t.references :report, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
