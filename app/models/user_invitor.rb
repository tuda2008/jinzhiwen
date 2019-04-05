class UserInvitor < ApplicationRecord
  belongs_to :user
  belongs_to :invitation

  validates :user_id, :invitation_id, presence: true
  validates :user_id, :uniqueness => { :scope => :invitation_id }
end