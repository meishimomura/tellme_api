class User < ApplicationRecord
  belongs_to :school
  belongs_to :group
  has_many :users, dependent: :destroy
end
