class CreateAppVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :app_versions do |t|
	  t.integer  :code,          limit: 4,     default: 1, null: false, comments: "版本号" 
	  t.string   :name,          limit: 255,               null: false, comments: "版本名" 
	  t.integer  :mobile_system, limit: 4, default: AppVersion::MOBILESYSTEMS[:wechat_mini], null: false, comments: "版本类型：ios、android、wechat_mini" 
	  t.text     :content,       limit: 1000,              null: false, comments: "版本更新类容" 
	  t.datetime :created_at
    end

	add_index :app_versions, :code
	add_index :app_versions, :mobile_system
    add_index :app_versions, [:code, :mobile_system], unique: true
  end
end