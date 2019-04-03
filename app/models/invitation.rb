class Invitation < ApplicationRecord
  MAX_LIMIT = 5
  MAX_DAYS_EXPIRED = 3

  belongs_to :device
  belongs_to :user

  validates :invitation_token, uniqueness: { case_sensitive: false }
end