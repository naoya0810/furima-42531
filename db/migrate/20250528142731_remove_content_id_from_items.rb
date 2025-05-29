class RemoveContentIdFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :content_id, :integer
  end
end
