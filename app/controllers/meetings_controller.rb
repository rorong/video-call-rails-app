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

  private

  def meeting_params
     params.require(:meeting).permit(:title, :description, :user_id)
  end
end
