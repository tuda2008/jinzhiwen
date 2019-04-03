class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.integer  :user_id, null: false
      t.integer  :device_id, null: false

      t.string   :invitation_token, null: false
      t.integer  :invitation_limit, null: false, default: Invitation::MAX_LIMIT, comments: "每个邀请码试用最大次数"

      t.datetime :invitation_expired_at, comments: "过期时间"
      t.datetime :invitation_accepted_at, comments: "接受邀请时间"

      t.datetime :invitation_created_at
    end

    add_index :invitations, :invitation_token, unique: true
    add_index :invitations, :user_id
    add_index :invitations, :device_id
    add_index :invitations, [:user_id, :device_id]
  end
end