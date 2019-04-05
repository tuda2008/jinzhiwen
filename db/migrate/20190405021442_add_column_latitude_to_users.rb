class AddColumnLatitudeToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :latitude, :string, limit: 30, default: ""
  	add_column :users, :longitude, :string, limit: 30, default: ""
  	add_column :users, :address, :string, limit: 120, default: ""
  	add_index  :users, [:latitude, :longitude]
  	add_index  :users, :address
  end
end