class Api::V1::TextpairController < ApplicationController
  before_action :authenticate_api_v1_user!
  def show
    comment = Comment.find(params[:id])
    query = <<~TEXT
      SELECT comments.*, users.user_name, users.user_is_student, subjects.subject_name, subjects.subject_is_secret, COUNT(votes.comment_id) AS vote_count,
      CASE
        WHEN COUNT(votes.uid = ?) then true
        ELSE false
      END AS voted
      FROM comments
      INNER JOIN users USING(uid)
      INNER JOIN subjects
      ON comments.subject_id = subjects.id
      LEFT JOIN votes
      ON comments.id = votes.comment_id
      WHERE comments.subject_id = ?
      AND NOT comments.id = ?
      AND parent_comment_id IS NULL
      GROUP BY comments.id
      ORDER BY "created_at" DESC;
    TEXT
    other_comments = Comment.find_by_sql([query, current_api_v1_user.uid, comment.subject_id, params[:id]])
    near_comments = []
    other_comments.each do |other_comment|
      textpair = Api::Textpair::Request.new(comment.comment_content, other_comment.comment_content)
      response = textpair.request
      if response.header.status_code == 200
        respons_body = JSON.parse(response.body)
        if respons_body["score"] >= 0.6
          comment_data = {
            id: other_comment.id,
            subject_id: other_comment.subject_id,
            uid: other_comment.uid,
            parent_comment_id: other_comment.parent_comment_id,
            comment_content: other_comment.comment_content,
            comment_is_settled: other_comment.comment_is_settled,
            created_at: other_comment.created_at,
            updated_at: other_comment.updated_at,
            user_name: other_comment.user_name,
            user_is_student: other_comment.user_is_student,
            subject_name: other_comment.subject_name,
            subject_is_secret: other_comment.subject_is_secret,
            vote_count: other_comment.vote_count,
            voted: other_comment.voted
          }
          near_comments.push(comment_data)
        end
        next
      else
        render json: { status: 'ERROR' }
        break
      end
    end
    render json: { status: 'SUCCESS', data: near_comments }
  end
end
