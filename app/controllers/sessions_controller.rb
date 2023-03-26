class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else 
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        session.delete :user_id
        render json: {message: "Successful logout"}, status: :ok
    end
end
