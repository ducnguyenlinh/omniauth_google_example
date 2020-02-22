class Users::OmniauthCallbacksController < ApplicationController
  def google_oauth2
    callback_for(:google)
  end

  private

  def callback_for(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      # TODO:  Change me
      redirect_to home_index_path
    end
  end
end
