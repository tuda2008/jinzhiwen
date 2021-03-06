ActiveAdmin.register Supplier do
  permit_params :name, :abbr, :intro, :address, :tel, {images:[], category_ids:[], product_ids:[]}, :visible

  menu priority: 2, label: proc{ I18n.t("activerecord.models.supplier") }

  filter :name
  filter :abbr
  filter :tel
  filter :categories
  filter :products
  filter :visible

  scope("全部A") { |supplier| supplier.all }
  scope("可见厂家Y") { |supplier| supplier.visible }
  scope("不可见厂家N") { |supplier| supplier.invisible }

  index do
    selectable_column
    id_column
    column :name
    column :abbr
    column :tel
    column :categories do |supplier|
      supplier.categories.visible.map(&:title).join('，')
    end
    column :products do |supplier|
      supplier.products.visible.map(&:title).join('，')
    end
    column :visible
    actions
  end

  show do 
    attributes_table do
      row :id
      row :name
      row :abbr
      row :intro
      row :address
      row :tel
      row :categories do |supplier|
        supplier.categories.visible.map(&:title).join('，')
      end
      row :products do |supplier|
        supplier.products.visible.map(&:title).join('，')
      end
      row :images do |supplier|
        ul do
          supplier.images.each do |img|
            span do
              image_tag(img.url(:small))
            end
          end
        end
      end
      row :visible
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :abbr
      f.input :intro
      f.input :address
      f.input :tel
      f.input :categories, :as => :check_boxes, :collection => Category.visible.pluck(:title, :id)
      f.input :products, :as => :check_boxes, :collection => Product.visible.pluck(:title, :id)
      f.input :images, as: :file, input_html: { multiple: true }, hint: '尺寸不小于100x100'
      f.input :visible
    end
    f.actions
  end

end