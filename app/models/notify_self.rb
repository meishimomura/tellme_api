class NotifySelf < ApplicationRecord
  belongs_to :comment, class_name: 'Comment', :foreign_key => 'comment_id', optional: true
  belongs_to :parent_comment, class_name: 'Comment', :foreign_key => 'parent_comment_id', optional: true
  belongs_to :user, foreign_key: :to_uid
  belongs_to :user, foreign_key: :from_uid
end
