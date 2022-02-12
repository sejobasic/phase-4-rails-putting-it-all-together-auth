class ApplicationController < ActionController::API
  before_action :authorize
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
# before we do anything lets authorize and see if they are a user

  private

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
  end

  def render_unprocessable_entity_response(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

end
