class Api::V1::GroupDirectorsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_group_director, only: [:show, :update, :destroy]

  def index
    group_directors = GroupDirector.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded groups', data: group_directors }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the group', data: @group_director }
  end

  def create
    group_director = GroupDirector.new(group_director_params)
    if group_director.save
      render json: { status: 'SUCCESS', data: group_director }
    else
      render json: { status: 'ERROR', data: group_director.errors }
    end
  end

  def destroy
    @group_director.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @group_director }
  end

  def update
    if @group_director.update(group_director_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @group_director }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @group_director.errors }
    end
  end

  private

  def set_group_director
    @group_director = GroupDirector.find(params[:id])
  end

  def group_director_params
    params.permit(:subject_id, :group_id)
  end

end
