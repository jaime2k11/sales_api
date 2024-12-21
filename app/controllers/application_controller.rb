# Codigo base para todos los controllers
class ApplicationController < ActionController::API

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def current_user
    return @current_user if @current_user

    auth_header = request.headers['Authorization']
    return nil unless auth_header

    token = auth_header.split(' ').last
    decoded_token = JsonWebToken.decode(token)

    @current_user = User.find_by(id: decoded_token[:user_id]) if decoded_token
  rescue JWT::DecodeError
    nil
  end

  def user_not_authorized
    render json: { error: "Acción no permitida" }, status: :forbidden
  end

end
