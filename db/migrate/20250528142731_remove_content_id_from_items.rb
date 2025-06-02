class RemoveContentIdFromItems < ActiveRecord::Migration[7.1]
  def up
    remove_column :items, :content_id
  end

  def down
    add_column :items, :content_id, :integer
  end
end
