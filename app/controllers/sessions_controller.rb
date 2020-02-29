class SessionsController < ApplicationController
  def destroy
    if current_user
      sign_out current_user
      flash[:success] = 'See you!'
    end

    redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end
end
