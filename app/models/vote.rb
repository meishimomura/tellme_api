class Vote < ApplicationRecord
  belongs_to :comment
  belongs_to :user, foreign_key: :uid
end
