class MeetingsController < ApplicationController
  
  def index
    @meetings = Meeting.all
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      redirect_to(meetings_path)
    else
      render(:new)
    end
  end

  def show
    @meeting = Meeting.find_by(id: params[:id])
    @token = @meeting.generate_opentok_token
    if @token.blank?
      redirect_to(meetings_path)
    end
  end

  private

  def meeting_params
     params.require(:meeting).permit(:title, :description, :user_id)
  end
end
