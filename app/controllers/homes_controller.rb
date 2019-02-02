class HomesController < ApplicationController

  before_action :set_user
  before_action :check_auth, only: [:update]

  def index
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path, flash: { notice: t('user.avatar.uploaded') }
    else
      render 'index'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

  def check_auth
    redirect_to root_path unless user_signed_in?
  end

  def set_user
    @user = current_user if user_signed_in?
  end

end