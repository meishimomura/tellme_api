class Subject < ApplicationRecord
  belongs_to :school
  has_many :group_directors, dependent: :destroy
  has_many :course_directors, dependent: :destroy
  has_many :comments, dependent: :destroy
end
