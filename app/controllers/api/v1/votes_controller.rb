class Api::V1::VotesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_vote, only: [:show, :update, :destroy]

  def index
    votes = Vote.order(created_at: :desc)
    render json: { status: 'SUCCESS', message: 'Loaded votes', data: votes }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded the vote', data: @vote }
  end

  def create
    vote = Vote.new(vote_params)
    if vote.save
      render json: { status: 'SUCCESS', data: vote }
    else
      render json: { status: 'ERROR', data: vote.errors }
    end
  end

  def destroy
    @vote.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the vote', data: @vote }
  end

  def update
    if @vote.update(vote_params)
      render json: { status: 'SUCCESS', message: 'Updated the vote', data: @vote }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @vote.errors }
    end
  end

  def count
    count = Vote.where(comment_id: params[:id]).count
    render json: { status: 'SUCCESS', message: 'Count', data: count }
  end

  private

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.permit(:comment_id, :uid)
  end

end
