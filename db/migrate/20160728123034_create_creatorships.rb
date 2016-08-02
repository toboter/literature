class CreateCreatorships < ActiveRecord::Migration[5.0]
  def change
    create_table :creatorships do |t|
      t.references :creator, foreign_key: true
      t.references :subject, foreign_key: true
      t.integer :position
      t.string :type

      t.timestamps
    end
  end
end
