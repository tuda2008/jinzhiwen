# == Schema Information
#
# Table name: redactor2_assets
#
#  id                :integer          not null, primary key
#  data_file_name    :string(255)      not null
#  data_content_type :string(255)
#  data_file_size    :integer
#  assetable_id      :integer
#  assetable_type    :string(30)
#  type              :string(30)
#  width             :integer
#  height            :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Redactor2Rails::File < Redactor2Rails::Asset
  mount_uploader :data, Redactor2RailsFileUploader, mount_on: :data_file_name

  def url_content
    url(:content)
  end
end
