# == Schema Information
#
# Table name: supplier_products
#
#  id          :bigint(8)        not null, primary key
#  supplier_id :integer          not null
#  product_id  :integer          not null
#

class SupplierProduct < ApplicationRecord
  belongs_to :supplier
  belongs_to :product
end
