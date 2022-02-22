class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user, foreign_key: :uid
  belongs_to :original_comment, class_name: 'Comment', foreign_key: 'parent_comment_id', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_comment_id', dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :notify_selves, dependent: :destroy
  has_many :comment_notify_selves, class_name: 'NotifySelf', :foreign_key => 'comment_id'
  has_many :parent_comment_notify_selves, class_name: 'NotifySelf', :foreign_key => 'parent_comment_id'

  mount_uploader :comment_image_path, ImageUploader
end
