class AddColumnContentToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :content, :string, limit: 60, default: ""
    add_index  :messages, :content
  end
end