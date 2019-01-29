class SessionsController < ApplicationController

  def new
    user_signed_in? ? redirect_to(root_path, flash: { alert: t('session.already_logged_in') }) : render('new')
  end

  def create
    if params[:nickname].blank?
      flash.alert = t('session.nickname_is_blank')
      render "new"
    else
      user = User.find_by_nickname(params[:nickname])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, flash: { notice: t('session.login_successfull') }
      else
        flash.alert = t('session.wrong_nickname_or_password')
        render "new"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end