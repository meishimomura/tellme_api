class Api::V1::SchoolsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_school, only: [:show, :update, :destroy]

  def index
    schools = School.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded schools', data: schools }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the school', data: @school }
  end

  def create
    school = School.new(school_params)
    if school.save
      render json: { status: 'SUCCESS', data: school }
    else
      render json: { status: 'ERROR', data: school.errors }
    end
  end

  def destroy
    @school.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @school }
  end

  def update
    if @school.update(school_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @school }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @school.errors }
    end
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.permit(:school_name, :school_image_path)
  end

end
