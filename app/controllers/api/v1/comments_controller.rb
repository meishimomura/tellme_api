class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    comments = Comment.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the comment', data: @comment }
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { status: 'SUCCESS', data: comment }
    else
      render json: { status: 'ERROR', data: comment.errors }
    end
  end

  def destroy
    @comment.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the comment', data: @comment }
  end

  def update
    if @comment.update(comment_params)
      render json: { status: 'SUCCESS', message: 'Updated the comment', data: @comment }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @comment.errors }
    end
  end

  def all_show
    query = <<~TEXT
      WITH RECURSIVE r AS (
        SELECT * FROM comments WHERE id = ?
        UNION ALL
        SELECT comments.* FROM comments, r WHERE comments.parent_comment_id = r.id
      )
      SELECT r.*, users.user_name, users.user_is_student, subjects.subject_name FROM r
      INNER JOIN
      users
      ON r.uid = users.uid
      INNER JOIN
      subjects
      ON r.subject_id = subjects.id
      ORDER BY "created_at" ASC;
    TEXT
    comments = Comment.find_by_sql([query, params[:id]])
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:subject_id, :uid, :parent_comment_id, :comment_content)
  end

end