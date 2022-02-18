require "google/cloud/vision"

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
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    file_path = comment.comment_image_path.url
    response = image_annotator.text_detection(image: file_path)
    response.responses.each do |res|
      comment.comment_image_text = res.text_annotations[0].description
    end
    if comment.save
      comment_data = Comment.joins(:user).joins(:subject).select("comments.*, users.user_name, users.user_is_student, subjects.subject_name, subjects.subject_is_secret").find(comment.id)
      render json: { status: 'SUCCESS', data: comment_data }
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
      WHERE comments.id = ?
      GROUP BY comments.id
      ORDER BY "created_at" DESC;
    TEXT
    comment = Comment.find_by_sql([query, current_api_v1_user.uid, @comment.id])
      render json: { status: 'SUCCESS', message: 'Updated the comment', data: comment }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @comment.errors }
    end
  end

  def common_index
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
      WHERE comments.subject_id IN
      (
        SELECT subject_id FROM group_directors
        INNER JOIN users USING(group_id)
        WHERE group_id = ?
      )
      AND parent_comment_id IS NULL
      AND subjects.subject_is_secret = false
      GROUP BY comments.id
      ORDER BY "created_at" DESC;
    TEXT
    comments = Comment.find_by_sql([query, current_api_v1_user.uid, current_api_v1_user.group_id])
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }
  end

  def all_index
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
      WHERE comments.subject_id IN
      (
        SELECT subject_id FROM course_directors
        WHERE uid = ?
      )
      AND parent_comment_id IS NULL
      GROUP BY comments.id
      ORDER BY "created_at" DESC;
    TEXT
    comments = Comment.find_by_sql([query, current_api_v1_user.uid, current_api_v1_user.uid])
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }
  end

  def all_show
    query = <<~TEXT
      WITH RECURSIVE r AS (
        SELECT * FROM comments WHERE id = ?
        UNION ALL
        SELECT comments.* FROM comments, r WHERE comments.parent_comment_id = r.id
      )
      SELECT r.*, users.user_name, users.user_is_student, subjects.subject_name, subjects.subject_is_secret,
      COUNT(votes.comment_id) AS vote_count,
      CASE
        WHEN COUNT(votes.uid = ?) then true
        ELSE false
      END AS voted
      FROM r
      INNER JOIN
      users
      ON r.uid = users.uid
      INNER JOIN
      subjects
      ON r.subject_id = subjects.id
      LEFT JOIN votes
      ON r.id = votes.comment_id
      GROUP BY r.id
      ORDER BY "created_at" ASC;
    TEXT
    comments = Comment.find_by_sql([query, params[:id], current_api_v1_user.uid])
    count = Vote.where(comment_id: params[:id]).count
    voted = Vote.exists?(comment_id: params[:id], uid: current_api_v1_user.uid)
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }
  end

  private

  def set_comment
    @comment = Comment.joins(:user).joins(:subject).select("comments.*, users.user_name, users.user_is_student, subjects.subject_name, subjects.subject_is_secret").find(params[:id])
  end

  def comment_params
    params.permit(:subject_id, :uid, :parent_comment_id, :comment_content, :comment_is_settled, :comment_image_path)
  end

end
