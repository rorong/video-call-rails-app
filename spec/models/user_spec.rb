require 'rails_helper'

RSpec.describe User, type: :model do

  subject { FactoryGirl.create(:user) }

  it { is_expected.to have_many(:meetings) }

  describe '#valid?' do
    context 'when email is present' do
      before { subject.email = 'test@user.com' }

      it { is_expected.to be_valid }
    end

    context 'when email is not present' do
      before { subject.email = nil }

      it { is_expected.not_to be_valid }
    end

    context 'when email is duplicated' do
      let(:user) { User.create }
      before { subject.email = user.email }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#destroy' do
    let!(:user) { FactoryGirl.create(:user) }
    it 'should destroy user' do
      expect { user.destroy }.to change(User, :count).by(-1)
    end
  end
end
