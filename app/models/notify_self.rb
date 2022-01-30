class NotifySelf < ApplicationRecord
  belongs_to :user, foreign_key: :to_uid
  belongs_to :user, foreign_key: :from_uid
end
