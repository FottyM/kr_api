# app/controllers/users_controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  skip_before_action :authenticate_request, only: %i[login register]

  def show
    render json: @user
  end

  def register
    @user = User.new(user_params)

    if @user.save
      render json: { id: @user.id, message: 'user registration successful' },
             status: :created,
             location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    authenticate auth_params
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @user.destroy
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    @user = { id: @user.id, first_name: @user.first_name,
              last_name: @user.last_name, email: @user.email }
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  #  Only these two params when a user wants to authenticate
  def auth_params
    params.require(:user).permit(:email, :password)
  end

  # Authenticate with emial and passowrd
  def authenticate(auth_params)
    command = AuthenticateUser.call(auth_params[:email], auth_params[:password])
    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
