module Komposable
  class MediasController < BaseController
    skip_before_action :set_class_variables

    def index
      @items = policy_scope(ActiveStorage::Blob).page(params[:page]).per(24)
      authorize ActiveStorage::Blob, :index?
    end

    def show
      @item = ActiveStorage::Blob.find(params[:id])
      authorize @item
      @index_path = [komposable, :medias]
    end
  end
end
