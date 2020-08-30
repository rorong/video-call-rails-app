class Meeting < ApplicationRecord
  belongs_to :user

  validates_presence_of :tokbox_session_id
  before_validation :generate_opentok_session, if: -> { new_record? }

  def generate_opentok_session
    opentok_service = OpentokService.new
    result, _error = opentok_service.create_session
    if result.present?
      self.tokbox_session_id = result.session_id
    end
  end

  def generate_opentok_token
    opentok_service = OpentokService.new
    result, error = opentok_service.generate_token(self.tokbox_session_id, opts = {
      role:                      :moderator,
      expire_time:               Time.now.to_i + (60 * 60), # in one hours
      data:                      "email=#{user.email}",
      initial_layout_class_list: %w[focus inactive],
    })
    result
  end

end
