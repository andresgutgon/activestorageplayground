module Account
  class ProfilesController < ApplicationController
    before_action :require_current_user!

    def update
      byebug
      if profile_params[:avatar]
        Current.user.avatar.attach(profile_params[:avatar])
      end
      return redirect_to root_path
      # TODO: Edit profile for example
    end

    private

    def profile_params
      params.require(:user).permit(:name, :email, :avatar)
    end
  end
end
