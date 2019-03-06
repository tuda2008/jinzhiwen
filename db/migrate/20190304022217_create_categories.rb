class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string   :title, limit: 255, null: false, comments: "类别"
      t.string   :intro, limit: 255, default: "", comments: "描述"

      t.string   :images, comments: "封面"
      t.boolean  :visible, default: false, comments: "是否可见"
    end

    add_index :categories, :title, unique: true
    add_index :categories, :intro
    add_index :categories, :visible
    add_index :categories, [:title, :visible], unique: true
  end
end