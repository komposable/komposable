module Komposable
  class UsersController < BaseController

    private

    def set_class_variables(class_name = nil)
      super
      @index_path = [komposable, @klass_name.to_sym]
      if @namespace != 'komposable'
        @new_path = [komposable, :new, @namespace, @klass_singular.to_sym]
      else
        @new_path = [:new, @klass_singular.to_sym]
      end
    end
  end
end
