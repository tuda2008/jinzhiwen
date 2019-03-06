class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
	    t.string   :title, limit: 255, null: false, comments: "型号"
      t.string   :intro, limit: 255, default: "", comments: "描述"

      t.string   :images, comments: "封面"
      t.boolean  :visible, default: false, comments: "是否可见"

      t.timestamps
    end

    add_index :products, :title, unique: true
    add_index :products, :intro
    add_index :products, :visible
    add_index :products, [:title, :visible], unique: true
  end
end