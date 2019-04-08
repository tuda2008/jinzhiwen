class AddIndexToMessages < ActiveRecord::Migration[5.2]
  def change
  	add_index :messages, [:user_id, :content, :is_deleted, :created_at], name: "messages_user_content_visible_created"
  	add_index :messages, [:user_id, :device_id, :content, :is_deleted, :created_at], name: "messages_user_device_content_visible_created"
  end
end