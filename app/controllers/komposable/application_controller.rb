module Komposable
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include Pundit
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
    before_action :require_login

    layout 'komposable/application'

    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    def index; end

    protected

    def not_authenticated
      redirect_to(
        komposable.login_path,
        alert: t("messages.not_authenticated")
      )
    end

    def not_authorized
      redirect_to(
        request.referer || komposable.root_path,
        alert: t("messages.not_authorized")
      )
    end
  end
end
