class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.string :name
      t.string :abbr

      t.timestamps
    end
    add_column :subjects, :serie_id, :integer
  end
end
