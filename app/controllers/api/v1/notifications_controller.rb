class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_notification, only: [:show, :update, :destroy]

  def index
    notifications = Notification.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded notifications', data: notifications }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the notification', data: @notification }
  end

  def create
    notification = Notification.new(notification_params)
    if notification.save
      render json: { status: 'SUCCESS', data: notification }
    else
      render json: { status: 'ERROR', data: notification.errors }
    end
  end

  def destroy
    @notification.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @notification }
  end

  def update
    if @notification.update(notification_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @notification }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @notification.errors }
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.permit(:uid, :group_id, :notification_title, :notification_content)
  end

end
