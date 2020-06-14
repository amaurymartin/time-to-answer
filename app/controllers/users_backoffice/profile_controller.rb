# frozen_string_literal: true

class UsersBackoffice::ProfileController < UsersBackofficeController
  before_action :set_user, only: %i[edit update destroy]
  before_action :verify_password, only: [:update]

  def edit
  end

  def update
    if @user.update(update_user_params)
      redirect_to users_backoffice_profile_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def create_user_params
    params.require(:user).permit(%i[first_name last_name email password password_confirmation])
  end

  def update_user_params
    params.require(:user).permit(%i[first_name last_name password password_confirmation])
  end

  def verify_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end
