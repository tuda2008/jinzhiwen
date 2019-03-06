class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string   :name, limit: 120, null: false, comments: "厂家名称"
      t.string   :abbr, limit: 60, null: false, comments: "品牌"
      t.string   :intro, limit: 255, default: "", comments: "厂家简介"
      t.string   :address, limit: 255, default: "", comments: "厂家地址"
      t.string   :tel, limit: 255, default: "", comments: "厂家联系方式"

      t.string   :images, comments: "封面"
      t.boolean  :visible, default: false, comments: "是否可见"

      t.timestamps
    end

    add_index :suppliers, :name, unique: true
    add_index :suppliers, :abbr
    add_index :suppliers, :intro
    add_index :suppliers, :address
    add_index :suppliers, :tel
    add_index :suppliers, :visible
    add_index :suppliers, [:name, :visible], unique: true
  end
end