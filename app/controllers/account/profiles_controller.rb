module Account
  class ProfilesController < ApplicationController
    before_action :require_current_user!

    def edit;end

    def update
      avatar = params[:user]&.dig(:avatar)
      if !avatar
        @error_messages = ['Please select profile avatar picture']
        return render :edit, status: :unprocessable_entity
      end

      Current.user.avatar.attach(avatar)
      return redirect_to edit_profile_path
    end

    def delete_avatar
      Current.user.avatar.purge
      redirect_to edit_profile_path
    end
  end
end
