class Notification < ApplicationRecord
  belongs_to :user, foreign_key: :uid
  belongs_to :group
  has_many :notification_checks, dependent: :destroy
end
