require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
	login_user

  before { sign_in user }

  let(:meeting) { FactoryGirl.create(:meeting, user_id: subject.current_user.id, invitee_id: subject.current_user.id)}

  let(:user) { FactoryGirl.create(:user) }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:meeting, title:"M1", description:"",user_id:subject.current_user.id,invitee_id: subject.current_user.id, tokbox_session_id: "kasjhd86asd8asjkjl8")
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:meeting, name:'')
  }

  let(:valid_session) { {} }

  describe 'user logged in' do
    it 'user logged in' do
      expect(subject.current_user).not_to be_nil
    end

    it 'user not logged in' do
      subject.current_user.id = nil
      expect(subject.current_user.id).to be_nil
    end
  end
  describe 'GET #index' do
    it "assigns all meetings as @meetings" do
      get :index
      expect(assigns(:meetings)).to eq([meeting])
    end
  end
  describe 'GET #new' do
    it "assigns a new meeting as @meeting" do
      get :new
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end
  end
  describe "GET #create" do
    context "with valid params" do
      it "creates a new Meeting" do
        expect {
          post :create, params: {invitee_id: subject.current_user, meeting: valid_attributes}
        }.to change(Meeting, :count).by(1)
      end

      it "assigns a newly created meeting as @meeting" do
        post :create, params: {invitee_id:subject.current_user,meeting: valid_attributes}
        expect(assigns(:meeting)).to be_a(Meeting)
        expect(assigns(:meeting)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved course as @course" do
        post :create, params: { meeting: invalid_attributes}
        expect(assigns(:meeting)).to be_a_new(Meeting)
      end

      it "re-renders the 'new' template" do
        post :create, params: { meeting: invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryGirl.attributes_for(:meeting, title:"M2", description:"",user_id: subject.current_user.id,invitee_id: subject.current_user.id, tokbox_session_id: "kasjhd86asd8asjkjl8")
      }

      it "updates the requested meeting" do
      	meeting = Meeting.create! valid_attributes
        patch :update, params: {id: meeting.id, meeting: new_attributes}
        meeting.reload
        expect(assigns(:meeting)).to eq(meeting)
      end

      it "assigns the requested meeting as @meeting" do
      	meeting = Meeting.create! valid_attributes
        put :update, params: {id: meeting.id, meeting: valid_attributes}
        expect(assigns(:meeting)).to eq(meeting)
      end

      it "redirects to the meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, params: {id: meeting.id, meeting: valid_attributes}
        expect(response).to redirect_to(meeting_path)
      end
    end

    context "with invalid params" do
      it "assigns the meeting as @meeting" do
        meeting = Meeting.create! valid_attributes
        put :update, params: { id: meeting.id, meeting: invalid_attributes }
        expect(assigns(:meeting)).to eq(meeting)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested course" do
      meeting = Meeting.create! valid_attributes
      expect {
        delete :destroy, params: { id: meeting.id }
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the meetings list" do
      meeting = Meeting.create! valid_attributes
      delete :destroy, params: { id: meeting.id }
      expect(response).to redirect_to(meetings_url)
    end
  end
end
