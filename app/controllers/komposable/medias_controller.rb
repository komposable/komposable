module Komposable
  class MediasController < BaseController
    skip_before_action :set_class_variables

    def index
      @items = policy_scope(ActiveStorage::Blob).order(created_at: :desc).page(params[:page]).per(24)
      authorize ActiveStorage::Blob, :index?
    end

    def show
      set_item
      @index_path = [komposable, :medias]
    end

    private

    def set_item
      @item = ActiveStorage::Blob.find(params[:id])
      authorize @item
    end

    def redirect_after_destroy
      [komposable, :medias]
    end
  end
end
