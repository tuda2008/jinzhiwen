class CreateCarousels < ActiveRecord::Migration[5.2]
  def change
    create_table :carousels do |t|
      t.string   :tag, limit: 255, null: false
      t.string   :url
      t.string   :images
      
      t.boolean  :visible, default: false
    end

    add_index :carousels, :tag, unique: true
    add_index :carousels, :url
    add_index :carousels, :visible
  end
end