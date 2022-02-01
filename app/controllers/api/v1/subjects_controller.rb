class Api::V1::SubjectsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_subject, only: [:show, :update, :destroy]

  def index
    subjects = Subject.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded subjects', data: subjects }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the subject', data: @subject }
  end

  def create
    subject = Subject.new(subject_params)
    if subject.save
      render json: { status: 'SUCCESS', data: subject }
    else
      render json: { status: 'ERROR', data: subject.errors }
    end
  end

  def destroy
    @subject.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @subject }
  end

  def update
    if @subject.update(subject_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @subject }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @subject.errors }
    end
  end

  def user_index
    if current_api_v1_user.user_is_student
      subjects = Subject.where(id: GroupDirector.where(group_id: current_api_v1_user.group_id).select("group_directors.subject_id"))
    else
      subjects = Subject.where(id: CourseDirector.where(uid: current_api_v1_user.uid).select("course_directors.subject_id"))
    end
    render json: { status: 'SUCCESS', message: 'Loaded the subjects', data: subjects }
  end
  
  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.permit(:school_id, :subject_name)
  end
end
