class School < ApplicationRecord
  has_many :schools, dependent: :destroy
end
