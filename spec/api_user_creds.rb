# frozen_string_literal: true

module ApiUserCreds
  def api_user_name
    ENV["API_USER_NAME"]
  end

  def api_user_email
    ENV["API_USER_EMAIL"]
  end
end
