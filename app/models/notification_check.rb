class NotificationCheck < ApplicationRecord
  belongs_to :user, foreign_key: :uid
  belongs_to :notification
end
