class CreateCategoryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :category_products do |t|
      t.integer :category_id, null: false
      t.integer :product_id, null: false
    end

    add_index :category_products, :category_id
    add_index :category_products, :product_id
    add_index :category_products, [:category_id, :product_id], unique: true
  end
end