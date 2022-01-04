class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  belongs_to :parent_comment_id, class_name: 'Comments'
  has_many :child_comments, class_name: 'Comments', foreign_key: 'parent_comment_id', dependent: :nullify
  has_many :comments, dependent: :destroy
end
