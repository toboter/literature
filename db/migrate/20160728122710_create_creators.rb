class CreateCreators < ActiveRecord::Migration[5.0]
  def change
    create_table :creators do |t|
      t.string :fname
      t.string :lname

      t.timestamps
    end
  end
end
