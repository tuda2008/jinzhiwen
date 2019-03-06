class CreateSupplierCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :supplier_categories do |t|
      t.integer :supplier_id, null: false
      t.integer :category_id, null: false
    end

    add_index :supplier_categories, :supplier_id
    add_index :supplier_categories, :category_id
    add_index :supplier_categories, [:supplier_id, :category_id], unique: true
  end
end