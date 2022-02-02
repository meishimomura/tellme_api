class GroupOwner < ApplicationRecord
  belongs_to :group
  belongs_to :user, foreign_key: :uid
end
