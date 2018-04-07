module Komposable
  class Engine < Rails::Engine
    isolate_namespace Komposable

    require 'kaminari'
    require 'pundit'
    require 'sorcery'

    config.after_initialize do |app|
      app.config.komponent.component_paths.append(Komposable::Engine.root.join("frontend/components"))
    end

    initializer "komposable.action_dispatch" do |app|
      ActiveSupport.on_load :action_controller do
        ActionController::Base.prepend_view_path Komposable::Engine.root.join("frontend")
      end
    end

    initializer 'komposable.autoload', before: :set_autoload_paths do |app|
      app.config.autoload_paths << Komposable::Engine.root.join("frontend")
    end
  end
end
