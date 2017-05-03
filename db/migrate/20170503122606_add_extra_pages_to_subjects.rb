class AddExtraPagesToSubjects < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :extra_pages, :string
  end
end
