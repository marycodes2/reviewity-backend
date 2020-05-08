class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password(params[:password])
      render json: user.as_json(
        only: %i[email first_name last_name]
      ), status: :created
    else
      head :unauthorized
    end
  end

  def destroy

  end
end
