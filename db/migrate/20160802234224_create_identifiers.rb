class CreateIdentifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :identifiers do |t|
      t.references :subject, foreign_key: true
      t.string :ident_name
      t.string :ident_value

      t.timestamps
    end
  end
end
