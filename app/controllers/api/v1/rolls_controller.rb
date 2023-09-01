class Api::V1::RollsController < ApplicationController
  skip_forgery_protection
  skip_before_action :http_basic_authenticate
  before_action :http_token_authenticate

  def create
    respond_to do |format|
      format.json do
        render json: {hint: "This version of the API is no longer supported."}, status: :bad_request
      end
    end
  end

  private

  def http_token_authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.credentials.http_token)
    end
  end
end
