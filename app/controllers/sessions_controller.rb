class SessionsController < ApplicationController

  # Manejo de peticiones de inicio de sesion
  def create
    # Primero se revisa si las credenciales son validas
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      # En caso que la autenticacion sea correcta, se envia un token respectivo al usuario, para futuras consultas
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

end
