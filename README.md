# Create Rails App

```shell
$ rails new cat-tinder-backend -d postgresql -T
$ cd cat-tinder-backend
$ rails db:create
$ bundle add rspec-rails
$ rails generate rspec:install
$ rails server
```

## Switched drivers, installed dependencies

```shell
$ gem install
$ bundle install
$ yarn
$ rails db:create
$ rails generate resource Cat name:string age:integer enjoys:text image:text
$ rails db:migrate
$ rspec spec
$ rails db:seed
$ created hot jon b as a Cat
```

## API CORS

### updated .app/controllers/application_controller.rb

```ruby
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```

### updated ./Gemfile

```
gem 'rack-cors', :require => 'rack/cors'
```

### created config/initializers/cors.rb

```ruby
# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # <- change this to allow requests from any domain while in development.

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

### updated DEPENDENCIES

```shell
$ bundle
```
