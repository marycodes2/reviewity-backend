class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      payload = { user_id: user.id }

      token = encode_token(payload)

      render json: { user: user, jwt: token }
    else
      head :unauthorized
    end
  end

  def auto_login
    if current_user
      render json: current_user
    else
      render json: :unauthorized
    end
  end
end
