class RemoveOldTaggingSys < ActiveRecord::Migration[5.0]
  def up
    drop_table :taggings
    drop_table :tags
  end
  
  def down
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :taggings do |tg|
      tg.references :tag, foreign_key: true
      tg.references :subject, foreign_key: true

      tg.timestamps
    end
  end
end
