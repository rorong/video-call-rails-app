# frozen_string_literal: true

require 'opentok'
class OpentokService
  def initialize
    api_key = "46904164"#ENV['TOKBOX_API_KEY']
    api_secret = "c996fabdf443146a19641b724c9fba6db305aee1" #ENV['TOKBOX_SECRET_KEY']
    @opentok = OpenTok::OpenTok.new(api_key, api_secret, timeout_length: 10)
  end

  def create_session(opts = {})
    begin
      result = @opentok.create_session(opts)
    rescue Exception => e
      error = e.message
    end
    log_result(result, error)
    [result, error]
  end

  def generate_token(session_id, opts = {})
    begin
      result = @opentok.generate_token(session_id, opts)
    rescue Exception => e
      error = e.message
    end
    log_result(result, error)
    [result, error]
  end

  private

  def log_result(response, error)
    if response.present?
      Rails.logger.warn('================OPEN-TOK API EXECUTED SUCCESSFULLY===========================')
      Rails.logger.warn(response.to_s)
      Rails.logger.warn('================OPEN-TOK API EXECUTED SUCCESSFULLY===========================')
    else
      Rails.logger.error('================OPEN-TOK API ERROR===========================')
      Rails.logger.error("================#{error}=====================================")
      Rails.logger.error('================OPEN-TOK API ERROR===========================')
    end
  end
end
