# Komposable

[![Maintainability](https://api.codeclimate.com/v1/badges/a275eb10827d94d5795e/maintainability)](https://codeclimate.com/github/komposable/komposable/maintainability)

**Komposable** allows you to quickly build a modular back-office for your Rails app. It offers standard features and allows you to implement you own specific needs easily.

It's based on the following existing gems:

- [sorcery](https://github.com/Sorcery/sorcery) for authentication
- [pundit](https://github.com/varvet/pundit) for authorization
- [acts_as_list](https://github.com/swanandp/acts_as_list) for sorting records manually
- [kaminari](https://github.com/kaminari/kaminari) for pagination
- & our very own [komponent](https://github.com/komposable/komponent) for organizing front-end code as components

This gem has been inspired by [fae](https://github.com/wearefine/fae). It is developed by [Ouvrages](https://ouvrages-web.fr) and [Etamin Studio](https://etaminstudio.com).

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
