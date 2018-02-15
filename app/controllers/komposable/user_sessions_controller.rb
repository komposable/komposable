module Komposable
  class UserSessionsController < Komposable::ApplicationController
    skip_before_action :require_login, except: [:destroy]
    skip_after_action :verify_authorized, except: :index

    def new
      @user = User.new
    end

    def create
      if @user = login(user_session_params[:email], user_session_params[:password])
        redirect_back_or_to(komposable.root_path, notice: "Welcome #{current_user.first_name}, you are now logged in!")
      else
        flash.now[:alert] = 'Login failed'
        render action: 'new'
      end
    end

    def destroy
      logout
      redirect_to(komposable.login_path, notice: 'You are now logged out.')
    end

    private

    def user_session_params
      params.require(:user_session).permit(:email, :password)
    end
  end
end
