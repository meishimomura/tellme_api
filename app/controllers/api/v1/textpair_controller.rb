class Api::V1::TextpairController < ApplicationController
  before_action :authenticate_api_v1_user!
  def show
    comment = Comment.find(params[:id])
    other_comments = Comment.where(subject_id: comment.subject_id).where.not(id: params[:id]).where(parent_comment_id: nil)
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
            comment_content: other_comment.comment_content
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
