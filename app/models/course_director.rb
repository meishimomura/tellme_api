class CourseDirector < ApplicationRecord
  belongs_to :user, foreign_key: :uid
  belongs_to :subject
end
