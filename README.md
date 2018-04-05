# Komposable

# Getting started

```ruby
# Gemfile

gem "komposable"

# For now, we have to add it manually
# TODO: include it in the gemspec dependencies
gem 'meta-tags', github: 'etaminstudio/meta-tags', branch: 'rename-title-helper'
```

Copy and run the migrations from the engine:

```
bin/rails komposable:install:migrations
bin/rails db:migrate
```

Add at the beginning of the routes:

```ruby
# config/routes.rb

namespace :admin do
  root "pages#index"
  resources :pages
end

mount Komposable::Engine => "/admin"
```

Add at the end of the file:

```ruby
# config/initializers/assets.rb

Rails.application.config.assets.precompile += %w( admin.js admin.css )
```

Add the engine path to resolved paths for webpacker and postcss:

```yml
# config/webpacker.yml

  resolved_paths:
    - frontend
    - vendor/komposable/frontend
```

```yml
# .postcssrc.yml

  postcss-import: {
    path: [
      'frontend',
      'vendor/komposable/frontend'
    ]
  }
```

Create a new javascript pack:

```js
// frontend/packs/admin.js

import "komposable/frontend/packs/admin";
```

Create the NavigationConcern:

```rb
# app/controllers/concerns/admin/navigation_concern.rb
# TODO: replace with a component to be overriden in the main app

module Admin
  module NavigationConcern
    extend ActiveSupport::Concern
    # This concern helps you configure Komposable admin panel navigation

    def site_name
      # This name will be displayed in the header.
      t("site_name")
    end

    class Item < Struct.new(:text, :href); end

    def items
      # These are the items that will be displayed in the main navigation.
      # Start the path with `[main_app, :admin, ...]` if the controller lives in the main app, or with `[komposable, ...]` if it's from the engine.
      return [] unless logged_in?

      i = []

      # i << Item.new("Pages", [main_app, :admin, :pages]) if policy(Page).index?
      i << Item.new("Medias", [komposable, :medias]) #if policy(Media).index?
      i << Item.new("Users", [komposable, :users]) if policy(User).index?

      i
    end
  end
end
```
