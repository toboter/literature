class AddUrlCodeToSubject < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :url_code, :string
    add_column :subjects, :cite_base, :string
    add_column :subjects, :cite_seq_id, :integer
  end
end
