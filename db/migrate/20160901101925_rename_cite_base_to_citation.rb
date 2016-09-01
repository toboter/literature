class RenameCiteBaseToCitation < ActiveRecord::Migration[5.0]
  def change
    rename_column :subjects, :cite_base, :citation
  end
end
