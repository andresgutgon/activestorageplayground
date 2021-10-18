module Account
  class SessionsController < ApplicationController
    def new; end

    def create
      user = User.find_by(email: params[:email])
      # TODO: Implement authentication
      # if user.present? && user.authenticate(params[:password])
      if user.present?
        session[:user_id] = user.id
        redirect_to root_path, notice: 'Logged in successfully'
      else
        flash.now[:alert] = 'Invalid email or password'
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end
  end
end
