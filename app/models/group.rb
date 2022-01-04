class Group < ApplicationRecord
  has_many :groups, dependent: :destroy
end
