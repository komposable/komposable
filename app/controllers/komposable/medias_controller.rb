module Komposable
  class MediasController < BaseController
    skip_before_action :set_class_variables

    # GET /admin/items
    def index
      @items = policy_scope(ActiveStorage::Blob).page(params[:page]).per(24)
      authorize ActiveStorage::Blob, :index?
    end
  end
end
