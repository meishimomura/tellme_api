class Group < ApplicationRecord
  belongs_to :school
  has_many :users, dependent: :destroy
  has_many :group_directors, dependent: :destroy
end
