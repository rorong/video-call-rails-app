require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do
	login_user

  before { sign_in user }

  let(:meeting) do
    create(
      :meeting, user_id: subject.current_user.id,
      invitee_id: subject.current_user.id
    )
  end

  let(:user) { create(:user) }

  let(:invitee) { create(:user) }

  let(:valid_attributes) do
    FactoryGirl.attributes_for(
      :meeting, title:"M1", description: "test description",
      user: user, invitee_id: subject.current_user
    )
  end

  let(:invalid_attributes) do
    FactoryGirl.attributes_for(
      :meeting, title:'', description: ''
    )
  end

  describe 'user authentication' do
    it 'user logged in' do
      expect(subject.current_user).not_to be_nil
    end

    it 'user not logged in' do
      subject.current_user.id = nil
      expect(subject.current_user.id).to be_nil
    end
  end

  describe 'GET #index' do
    let(:meeting_1) do
      create(
        :meeting, user_id: subject.current_user.id,
        invitee_id: subject.current_user.id
      )
    end

    let(:meeting_2) do
      create(
        :meeting, user_id: user.id, invitee_id: user.id
      )
    end

    before { get :index }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'assigns meetings that belongs to logged in user' do
      expect(assigns(:meetings)).to eq([meeting_1])
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'assigns a new meeting as @meeting' do
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects to meetings_path' do
        post :create, params: {
          meeting: valid_attributes
        }
        expect(response).to redirect_to(meetings_path)
      end

      it 'creates a meeting successfully' do
        expect{
          post :create, params: { meeting: valid_attributes, invitee: subject.current_user
          }
        }.to change(Meeting, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        post :create, params: { meeting: invalid_attributes }
      end

      it 'renders new meeting template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        FactoryGirl.attributes_for(
          :meeting, title: "M2", description: "test desc",
          user: subject.current_user, invitee: subject.current_user
        )
      end

      before do
        @meeting = create(:meeting, user: subject.current_user,
                   invitee: subject.current_user)
        patch :update, params: {
          id: @meeting.id, meeting: new_attributes
        }
        @meeting.reload
      end

      it 'updates the title' do
        expect(@meeting.title).to eq('M2')
      end

      it 'updates the description' do
        expect(@meeting.description).to eq('test desc')
      end

      it 'redirects to meeting_path(meeting)' do
        expect(response).to redirect_to(meeting_path(@meeting))
      end
    end

    context 'with invalid params' do
      let(:new_attributes) do
        FactoryGirl.attributes_for(
          :meeting, title: "M2", description: "test desc"
        )
      end

      before do
        @meeting = create(:meeting, user: subject.current_user, invitee: subject.current_user)
        patch :update, params: {
          id: @meeting.id, meeting: new_attributes
        }
        @meeting.reload
      end

      it 'redirects to meetings_path' do
        expect(response).to redirect_to(meeting_path(@meeting))
      end
    end
  end

  describe 'GET #show' do
    context 'when show successfull' do
      let(:meeting) do
        create(:meeting, user: subject.current_user,
          invitee: subject.current_user
        )
      end

      before do
        get :show, params: { id: meeting.id }
      end

      it 'return 200 http status code' do
        expect(response.status).to eq 200
      end

      it 're-renders show template' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested course' do
      meeting = create(:meeting, user: user, invitee: invitee)
      expect{
        delete :destroy, params: { id: meeting.id }
      }.to change(Meeting, :count).by(-1)
    end

    it 'redirects to the meetings list when destroy' do
      meeting = create(:meeting, user: user, invitee: invitee)
      delete :destroy, params: { id: meeting.id }
      expect(response).to redirect_to(meetings_url)
    end
  end
end
