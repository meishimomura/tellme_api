class Api::V1::Student::SubjectsController < ApplicationController
  def show
    subjects = Subject.where(id: GroupDirector.where(group_id: params[:id]).select("group_directors.subject_id"))
    render json: { status: 'SUCCESS', message: 'Loaded the school', data: subjects }
  end
end
