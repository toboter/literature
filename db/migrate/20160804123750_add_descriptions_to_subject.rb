class AddDescriptionsToSubject < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :g_description, :text
  end
end
