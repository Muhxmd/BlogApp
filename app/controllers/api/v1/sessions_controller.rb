class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      sign_in(user)

      render json: {
        message: "Logged in successfully",
        user: {
          id: user.id,
          email: user.email
        }
      }, status: :ok
    else
      render json: { error: "Invalid email or password" },
             status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user) if user_signed_in?

    render json: { message: "Logged out successfully" },
           status: :ok
  end

  def show
    if user_signed_in?
      render json: {
        id: current_user.id,
        email: current_user.email
      }, status: :ok
    else
      render json: { error: "Not authenticated" },
             status: :unauthorized
    end
  end
end
