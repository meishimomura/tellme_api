class Api::V1::Student::SubjectsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    subjects = Subject.where(id: GroupDirector.where(group_id: current_api_v1_user.group_id).select("group_directors.subject_id"))
    render json: { status: 'SUCCESS', message: 'Loaded the subjects', data: subjects }
  end
end
