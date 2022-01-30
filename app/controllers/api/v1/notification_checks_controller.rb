class Api::V1::NotificationChecksController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_notification_check, only: [:show, :update, :destroy]

  def index
    notification_checks = NotificationCheck.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded notification_checks', data: notification_checks }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the notification_check', data: @notification_check }
  end

  def create
    notification_check = NotificationCheck.new(notification_check_params)
    if notification_check.save
      render json: { status: 'SUCCESS', data: notification_check }
    else
      render json: { status: 'ERROR', data: notification_check.errors }
    end
  end

  def destroy
    @notification_check.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @notification_check }
  end

  def update
    if @notification_check.update(notification_check_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @notification_check }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @notification_check.errors }
    end
  end

  private

  def set_notification_check
    @notification_check = NotificationCheck.find(params[:id])
  end

  def notification_check_params
    params.permit(:uid, :notification_id)
  end

end
