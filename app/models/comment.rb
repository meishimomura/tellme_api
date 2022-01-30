class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user, foreign_key: :uid
  belongs_to :original_comment, class_name: 'Comment', foreign_key: 'parent_comment_id', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_comment_id', dependent: :destroy
end
