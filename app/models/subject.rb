class Subject < ApplicationRecord
  belongs_to :school
  has_many :subjects, dependent: :destroy
end
