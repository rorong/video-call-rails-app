require 'rails_helper'

RSpec.describe OpentokService do

  let(:api_key) { ENV['api_key'] }
  let(:api_secret) { ENV['api_secret'] }

  let(:opentok_service) do
    OpentokService.new
  end

  describe 'create_session' do
    it 'tokbox session created successfully' do
      expect(opentok_service.create_session.first.session_id).not_to be_nil
    end
  end

  describe 'generate_token' do
    let(:opentok_session_id) { opentok_service.create_session.first.session_id }
    let(:opentok_token) { opentok_service.generate_token(opentok_session_id) }

    it 'tokbox token generated successfully' do
      expect(opentok_token.first).not_to be_nil
    end
  end
end
