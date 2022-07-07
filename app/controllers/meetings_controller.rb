class MeetingsController < ApplicationController
  before_action :find_meeting, only: %i[show edit update destroy] 

  def index
    @meetings = Meeting.where("user_id = ? OR invitee_id = ?", current_user.id, current_user.id).order('created_at DESC')
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = current_user.meetings.new(meeting_params)
    if @meeting.save
      redirect_to(meetings_path)
    else
      render(:new)
    end
  end

  def show
    @token = @meeting.generate_opentok_token
    if @token.blank?
      redirect_to(meetings_path)
    end
  end

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to(meeting_path)
    else
      render(:edit)
    end
  end

  def destroy
    if @meeting.destroy
      redirect_to(meetings_path)
    else
      redirect_to(meetings_path)
    end
  end

  private

  def meeting_params
     params.require(:meeting).permit(:title, :description, :invitee_id)
  end

  def find_meeting
    @meeting = Meeting.find_by(id: params[:id])
  end
end
