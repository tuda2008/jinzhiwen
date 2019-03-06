class CreateSupplierProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :supplier_products do |t|
      t.integer :supplier_id, null: false
      t.integer :product_id, null: false
    end

    add_index :supplier_products, :supplier_id
    add_index :supplier_products, :product_id
    add_index :supplier_products, [:supplier_id, :product_id], unique: true
  end
end