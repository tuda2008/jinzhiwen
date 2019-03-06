# == Schema Information
#
# Table name: supplier_categories
#
#  id          :bigint(8)        not null, primary key
#  supplier_id :integer          not null
#  category_id :integer          not null
#

class SupplierCategory < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
end
