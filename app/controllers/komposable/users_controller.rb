module Komposable
  class UsersController < BaseController
    def edit
      super
      @index_path = [komposable, :root] unless policy(@klass).index?
    end

    private

    def set_class_variables(class_name = nil)
      super
      @index_path = [komposable, @klass_name.to_sym]
      @new_path = if @namespace != 'komposable'
                    [komposable, :new, @namespace, @klass_singular.to_sym]
                  else
                    [:new, @klass_singular.to_sym]
                  end
    end

    def item_params
      permitted_attributes(@klass)
    end
  end
end
