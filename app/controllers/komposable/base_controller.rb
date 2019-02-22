module Komposable
  class BaseController < Komposable::ApplicationController
    before_action :set_class_variables
    before_action :set_item, only: %i[edit update destroy]
    before_action :set_page_title, only: %i[new edit]

    # GET /admin/items
    def index
      authorize @klass, :index?
      set_meta_tags title: @klass_name.humanize
      @items = policy_scope(@klass).page params[:page]

      # You can specify the default sorting and scoping
      # by adding `admin_scope` as a class method on your model.
      @items = @items.admin_scope if @klass.respond_to? :admin_scope
    end

    # GET /admin/items/new
    def new
      @item = @klass.new
      authorize @item
    end

    # GET /admin/items/1/edit
    def edit
    end

    # POST /admin/items
    def create
      @item = @klass.new(item_params)
      authorize @item

      if @item.save
        notice = t("flashes.created_item", item: @klass_singular&.humanize)
        redirect_to redirect_after_create,
                    notice: notice
      else
        render :new
      end
    end

    # PATCH/PUT /admin/items/1
    def update
      if @item.update(item_params)
        notice = t("flashes.updated_item", item: @klass_singular&.humanize)
        redirect_to redirect_after_update,
                    notice: notice
      else
        render :edit
      end
    end

    # DELETE /admin/items/1
    def destroy
      if @item.destroy
        notice = t("flashes.destroyed_item", item: @klass_singular&.humanize)
        redirect_to redirect_after_destroy,
                    notice: notice
      else
        alert = t(
          "flashes.cannot_destroy_item",
          item: @klass_singular&.humanize,
          errors: @item.errors.messages[:base].join(", ")
        )
        redirect_to redirect_after_destroy,
                    alert: alert
      end
    end

    private

    def set_class_variables(class_name = nil)
      @namespace = params[:controller].split('/').first
      klass_base = params[:controller].split('/').last
      @klass_name = class_name || klass_base
      @klass = @klass_name.classify.constantize
      @klass_singular = @klass_name.singularize
      @index_path = [@namespace, @klass_name.to_sym]
      @new_path = if @namespace != 'komposable'
                    [:new, @namespace, @klass_singular.to_sym]
                  else
                    [:new, @klass_singular.to_sym]
                  end
    end

    def set_item
      @item = @klass.find(params[:id])
      authorize @item
    end

    def set_page_title
      key = "actions.#{params[:action]}_item"
      set_meta_tags title: t(key, item: @klass_singular.humanize)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      if @item.present? && @item.respond_to?(:permitted_attributes)
        permitted_attributes = @item.permitted_attributes
      elsif @klass.respond_to?(:permitted_attributes)
        permitted_attributes = @klass.permitted_attributes
      else
        raise "You have to define permitted_attributes for #{@klass}"
      end

      params.require(@klass_singular).permit(permitted_attributes)
    end

    # You can customize the redirections in your controller
    # by overriding the methods below.
    def redirect_after_create
      @index_path
    end

    def redirect_after_update
      @index_path
    end

    def redirect_after_destroy
      @index_path
    end
  end
end
