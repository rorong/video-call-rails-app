require 'rails_helper'

RSpec.describe Meeting, type: :model do
  let(:invitee) { FactoryGirl.create(:user) }
  let(:meeting_host) { FactoryGirl.create(:user) }

  subject { FactoryGirl.build(:meeting,user_id: meeting_host.id, invitee_id: invitee.id) }

  it { expect(subject).to belong_to(:user) }

  it { expect(subject).to belong_to(:invitee) }

  it { should validate_presence_of(:tokbox_session_id) }

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:meeting, title:"M1", description:"",user_id:meeting_host.id,invitee_id: invitee.id)
  }

  describe "valid?" do
    context 'when user is present' do
      it { is_expected.to be_valid }
    end

    context 'when user is not present' do
      before { subject.user_id = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when title is present' do
      it { is_expected.to be_valid }
    end

    it 'when new session is created' do
      #A session id must be present
      meeting= Meeting.create(title:"M1", description:"",user_id:meeting_host.id,invitee_id: invitee.id)
      expect(meeting.tokbox_session_id).not_to be_nil
    end

    context 'when session is not created' do
      before { subject.tokbox_session_id = nil }

      it { is_expected.not_to be_valid }
    end
  end
end
