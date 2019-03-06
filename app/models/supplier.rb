# == Schema Information
#
# Table name: suppliers
#
#  id         :bigint(8)        not null, primary key
#  name       :string(120)      not null
#  abbr       :string(60)       not null
#  intro      :string(255)      default("")
#  address    :string(255)      default("")
#  tel        :string(255)      default("")
#  images     :string(255)
#  visible    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Supplier < ApplicationRecord
  mount_uploaders :images, PhotoUploader
  serialize :images, Array

  has_many :supplier_categories, :dependent => :destroy
  has_many :categories, :through => :supplier_categories
  accepts_nested_attributes_for :categories, :allow_destroy => true

  has_many :supplier_products, :dependent => :destroy
  has_many :products, :through => :supplier_products
  accepts_nested_attributes_for :products, :allow_destroy => true

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 4..60 }
  validates :abbr, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..6 }
  validates :intro, :address, length: { allow_nil: true, maximum: 160 }
  validates :tel, length: { allow_nil: true, maximum: 60 }

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
end
