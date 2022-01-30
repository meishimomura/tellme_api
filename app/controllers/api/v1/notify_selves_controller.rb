class Api::V1::NotifySelvesController < ApplicationController
  # before_action :authenticate_api_v1_user!
  before_action :set_notify_self, only: [:show, :update, :destroy]

  def index
    notify_selves = NotifySelf.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded notifyselves', data: notify_selves }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the notify self', data: @notify_self }
  end

  def create
    notify_self = NotifySelf.new(notify_self_params)
    if notify_self.save
      render json: { status: 'SUCCESS', data: notify_self }
    else
      render json: { status: 'ERROR', data: notify_self.errors }
    end
  end

  def destroy
    @notify_self.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @notify_self }
  end

  def update
    if @notify_self.update(notify_self_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @notify_self }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @notify_self.errors }
    end
  end

  def user_index
    query = <<~TEXT
      SELECT "notify_selves".*, "from_user"."user_name" AS from_user_name
      FROM "notify_selves"
      INNER JOIN users AS from_user
      ON "notify_selves"."from_uid" = "from_user"."uid"
      WHERE "notify_selves"."to_uid" = ?
      ORDER BY "created_at" DESC
    TEXT
    notify_selves = NotifySelf.find_by_sql([query, current_api_v1_user.uid])
    render json: { status: 'SUCCESS', message: 'Loaded notify selves', data: notify_selves }
  end

  private

  def set_notify_self
    @notify_self = NotifySelf.find(params[:id])
  end

  def notify_self_params
    params.permit(:notify_type, :to_uid, :from_uid, :comment_id, :notify_is_checked)
  end

end
