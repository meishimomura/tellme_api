class Group < ApplicationRecord
  belongs_to :school
  has_many :users, dependent: :destroy
end
