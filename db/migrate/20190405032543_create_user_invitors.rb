class CreateUserInvitors < ActiveRecord::Migration[5.2]
  def change
    create_table :user_invitors do |t|
      t.integer  :invitation_id, null: false 
      t.integer  :user_id, null: false
      t.datetime :created_at
    end

    add_index :user_invitors, :user_id
    add_index :user_invitors, :invitation_id
    add_index :user_invitors, [:user_id, :invitation_id], unique: true
  end
end