class RemoveComments < ActiveRecord::Migration[5.0]
  def up
    drop_table :comments
  end
  
  def down
    create_table :comments do |t|
      t.references :subject, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
