class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_group, only: [:show, :update, :destroy]

  def index
    groups = Group.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded groups', data: groups }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the group', data: @group }
  end

  def create
    group = Group.new(group_params)
    if group.save
      render json: { status: 'SUCCESS', data: group }
    else
      render json: { status: 'ERROR', data: group.errors }
    end
  end

  def destroy
    @group.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @group }
  end

  def update
    if @group.update(group_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @group }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @group.errors }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.permit(:group_name, :group_grade, :school_id)
  end

end
