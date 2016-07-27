class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :slug
      t.string :title
      t.string :subtitle
      t.string :type
      t.integer :parent_id
      t.string :first_page
      t.string :last_page
      t.string :page_count
      t.string :volume
      t.string :published_date
      t.string :abbr
      t.string :edition
      t.string :language
      t.integer :publisher_id
      t.integer :place_id
      t.string :g_volume_id
      t.string :g_canonical_link
      t.string :g_image_thumbnail

      t.timestamps
    end
  end
end
