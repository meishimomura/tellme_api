class School < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :master_users, dependent: :destroy
  has_many :groups, dependent: :destroy
end
