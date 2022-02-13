class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    user = User.find_by(uid: current_api_v1_user.uid)
    if user.user_is_student
      user = User.joins(:school).joins(:group).select("users.*, schools.school_name, groups.group_grade, groups.group_name").find_by(uid: current_api_v1_user.uid)
    else
      user = User.joins(:school).select("users.*, schools.school_name").find_by(uid: current_api_v1_user.uid)
    end
    render json: { status: 'SUCCESS', message: 'Loaded user', data: user }
  end
end
