class UsersController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def create
        user = User.create(user_params_permit)
        if user.valid?
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end 

    def show
        user = User.find(session[:user_id])
        render json: user
    end

    private

    def user_params_permit
        params.permit(:username, :password, :password_confirmation)
    end

    def authorize
        render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    end
end
