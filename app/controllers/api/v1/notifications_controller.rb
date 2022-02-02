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

  def user_index
    query = <<~TEXT
      SELECT "notifications".*, "a"."uid" AS student_uid
      FROM "notifications"
      LEFT OUTER JOIN (
        SELECT
          "notification_checks"."notification_id",
          "notification_checks"."uid"
        FROM
          "notification_checks"
        WHERE
        "notification_checks"."uid" = ?
      ) AS a
      ON "notifications"."id" = "a"."notification_id"
      WHERE "notifications"."group_id" = ?
      ORDER BY "created_at" DESC
    TEXT
    if current_api_v1_user.user_is_student
      notifications = Notification.find_by_sql([query, current_api_v1_user.uid, current_api_v1_user.group_id])
    else
      notifications = Notification.where(group_id: GroupOwner.where(uid: current_api_v1_user.uid).select("group_owners.group_id")).order(created_at: :desc)
    end
    render json: { status: 'SUCCESS', message: 'Loaded notifications', data: notifications }
  end
  
  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.permit(:uid, :group_id, :notification_title, :notification_content)
  end

end
