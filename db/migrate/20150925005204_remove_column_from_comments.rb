class RemoveColumnFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :userm_id
  end
end
