class ApplicationController < ActionController::Base
  def append_info_to_payload(payload)
    super
    payload[:ip] = request.remote_ip
  end
end
