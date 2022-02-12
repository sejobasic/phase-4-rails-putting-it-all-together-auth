class SessionsController < ApplicationController
    skip_before_action :authorize, only: :create

    def create
      # find user param is coming from frontend
      user = User.find_by(username: params[:username])
      # if user && user password is true
      if user&.authenticate(params[:password])
      # creating a user id cookie and assigning to this users id
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      end
    end
  
    def destroy
      # Since user is authenticated above we then can logout
      session.delete :user_id
      head :no_content
    end

end
