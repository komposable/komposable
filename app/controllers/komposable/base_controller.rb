module Komposable
  class BaseController < Komposable::ApplicationController
    before_action :set_class_variables
    before_action :set_item, only: %i[edit update destroy]

    # GET /admin/items
    def index
      @items = policy_scope(@klass)
      authorize @klass, :index?
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

      if @item.save
        redirect_to @index_path, notice: "#{@klass_singular.humanize} was successfully created."
      else
        render :new
      end
    end

    # PATCH/PUT /admin/items/1
    def update
      if @item.update(item_params)
        redirect_to @index_path, notice: "#{@klass_singular.humanize} was successfully updated."
      else
        render :edit
      end
    end

    # DELETE /admin/items/1
    def destroy
      @item.destroy
      redirect_to @index_path, notice: "#{@klass_singular.humanize} was successfully destroyed."
    end

    private

    def set_class_variables(class_name = nil)
      @namespace = params[:controller].split('/').first
      klass_base = params[:controller].split('/').last
      @klass_name = class_name || klass_base
      @klass = @klass_name.classify.constantize
      @klass_singular = @klass_name.singularize
      @index_path = [@namespace, @klass_name.to_sym]
      if @namespace != 'komposable'
        @new_path = [:new, @namespace, @klass_singular.to_sym]
      else
        @new_path = [:new, @klass_singular.to_sym]
      end
    end

    def set_item
      @item = @klass.find(params[:id])
      authorize @item
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(@klass_singular).permit(@klass.permitted_attributes)
    end
  end
end
