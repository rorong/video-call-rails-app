require 'rails_helper'

RSpec.describe Meeting, type: :model do

  let(:invitee) { create(:user) }
  let(:meeting_host) { create(:user) }

  subject do
    create(
      :meeting, user_id: meeting_host.id,
      invitee_id: invitee.id
    )
  end

  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:invitee) }

  describe 'valid?' do
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
  end

  describe 'when meeting is a new record' do
    subject do
      create(
        :meeting, user: meeting_host, invitee: invitee
      )
    end

    it 'create tokbox_session_id successfully' do
      expect(subject.tokbox_session_id).not_to be_nil
    end
  end

  describe '#generate_opentok_token' do
    subject do
      create(
        :meeting, user: meeting_host, invitee: invitee
      )
    end

    it 'creates opentok_token successfully' do
      expect(subject.generate_opentok_token).not_to eq(nil)
    end

    it 'does not create opentok_token' do
      subject.tokbox_session_id = nil

      expect(subject.generate_opentok_token).to be_nil
    end
  end
end
