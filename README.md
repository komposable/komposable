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

# Navigation

To define your own navigation in the admin, you can override the `admin/header` component.

```
$ mkdir frontend/components/admin
$ cp -r vendor/komposable/frontend/components/admin/header frontend/components/admin
```
