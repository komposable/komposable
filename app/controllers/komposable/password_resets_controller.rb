module Komposable
  class PasswordResetsController < Komposable::ApplicationController
    # In Rails 5 and above, this will raise an error if
    # before_action :require_login
    # is not declared in your ApplicationController.
    skip_before_action :require_login
    skip_after_action :verify_authorized

    def new
    end

    # request password reset.
    # you get here when the user entered his email in the reset password form
    # and submitted it.
    def create
      @user = User.find_by(email: params[:email])

      # This line sends an email to the user with instructions on how to reset
      # their password (a url with a random token)
      @user&.deliver_reset_password_instructions!

      # Tell the user instructions have been sent whether or not email was found.
      # This is to not leak information to attackers about which emails exist
      # in the system.
      redirect_to(login_path, notice: 'Instructions have been sent to your email.')
    end

    # This is the reset password form.
    def edit
      @token = params[:id]
      @user = User.load_from_reset_password_token(params[:id])

      if @user.blank?
        not_authenticated
        return
      end
    end

    # This action fires when the user has sent the reset password form.
    def update
      @token = params[:id]
      @user = User.load_from_reset_password_token(params[:id])

      if @user.blank?
        not_authenticated
        return
      end

      # the next line disables the password confirmation
      @user.password_confirmation = params[:user][:password]

      # the next line clears the temporary token and updates the password
      if @user.change_password(params[:user][:password])
        redirect_to(login_path, notice: 'Your password was successfully changed, please log in.')
      else
        render action: "edit"
      end
    end
  end
end