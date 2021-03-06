class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.create(user_params)

    if user.valid?
      payload = { user_id: user.id }

      token = encode_token(payload)

      render json: { user: user, jwt: token }
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:password, :email, :first_name, :last_name)
  end
end
