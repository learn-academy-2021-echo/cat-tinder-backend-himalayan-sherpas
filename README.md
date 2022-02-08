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

# kirk goes here

# API Validations

## Model Card

### As a developer, I can add the appropriate model specs that will ensure an incomplete cat throws an error.

```ruby
# cat_spec.rb
require 'rails_helper'

RSpec.describe Cat, type: :model do
    it "should validate name, age, enjoys, and image to be populated" do
        cat = Cat.create
        expect(cat.errors[:name]).to_not be_empty
        expect(cat.errors[:age]).to_not be_empty
        expect(cat.errors[:enjoys]).to_not be_empty
        expect(cat.errors[:image]).to_not be_empty
    end
end
```

### As a developer, I can add the appropriate model validations to ensure the user submits a name, an age, what the cat enjoys, and an image.

```ruby
class Cat < ApplicationRecord
    validates :name, :age, :enjoys, :image, presence: true
end
```

### As a developer, I can add the appropriate model specs that will ensure a cat enjoys entry is at least 10 characters long.

```ruby
# spec/models/cat_spec.rb
class Cat < ApplicationRecord
    validates :name, :age, :enjoys, :image, presence: true
    validates :enjoys, length: {minimum: 10}
end
```

### As a developer, I can add a validation to assure that will ensure a cat enjoys entry is at least 10 characters long.

```ruby
# app/models/cat.rb
    it "validates enjoys to be at least 10 characters" do
        cat = Cat.create(enjoys:"123456789")
        expect(cat.errors[:enjoys]).to_not be_empty
    end
```

### As a developer, I can add the appropriate request validations to ensure the API is sending useful information to the frontend developer if a new cat is not valid.

```ruby

```
