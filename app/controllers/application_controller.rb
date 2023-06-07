class ApplicationController < ActionController::Base
  before_action :http_basic_authenticate

  def http_basic_authenticate
    unless ENV["RAILS_ENV"] == "test"
      http_basic_authenticate_or_request_with name: Rails.application.credentials.http_auth.name, password: Rails.application.credentials.http_auth.password
    end
  end
end
