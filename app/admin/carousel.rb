ActiveAdmin.register Carousel do
  permit_params :tag, :url, {images:[]}, :visible

  menu priority: 10, label: proc{ I18n.t("activerecord.models.carousel") }

  filter :tag, as: :select, collection: Carousel::TAG_COLLECTION
  filter :visible

  scope("全部A") { |carousel| carousel.all }
  scope("显示展播Y") { |carousel| carousel.visible }
  scope("不显示展播N") { |carousel| carousel.invisible }

  index do
    selectable_column
    id_column
    column(:tag, sortable: false) { |carousel| link_to carousel.tag, admin_carousel_path(carousel) }
    column :url
    column :visible
    actions
  end

  show do 
    attributes_table do
      row :id
      row :tag
      row :url
      row :images do |carousel|
        ul do
          carousel.images.each do |img|
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
      f.input :tag, :as => :select, :collection => Carousel::TAG_COLLECTION, prompt: "请选择"
      f.input :url, hint: '图片的链接地址，没有就留空'
      f.input :images, as: :file, input_html: { multiple: true }, hint: '尺寸不小于300x400'
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :visible
    end
    f.actions
  end

end