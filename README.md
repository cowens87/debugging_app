# Debugging Exercise: Rails API with Errors

## Overview

This Rails API app is riddled with deliberate errors in models, controllers, serializers, and routes. Your goal is to write tests, use debugging tools, and fix the issues. The app includes three main resources: `User`, `Post`, and `Comment`.

1. **Write Tests:** Create RSpec tests for the API endpoints in spec/requests, and test all CRUD actions for User, Post, and Comment. Use shoulda-matchers for model validations and associations.
2. **Debug with Pry**: Use `binding.pry` in controllers and models to investigate issues such as missing attributes, undefined variables, and incorrect associations. 
  - For example:
    - Insert `binding.pry` in each controller action to inspect instance variables and check parameter values.
    - Use `binding.pry` in models to inspect validation logic and associations.
3. `Rectify Errors:` Correct typos, missing validations, and broken associations. 
  - Here are some questions you should consider:
    - Are all associations correctly set up in each model?
    - Do validations match the intended behavior, and are they correct in syntax?
    - Do controllers handle nil cases, and are instance variables named consistently?
    - Are all route names correct in `config/routes.rb`?

## Getting Started

1. **Set Up the Project**:
   - Run `bundle install` to install dependencies.
   - Set up the database with `rails db:create db:migrate`.

2. **Add JSONAPI Serializer**:
   - The app uses `jsonapi-serializer` for serializing JSON responses.
   - Ensure `jsonapi-serializer` is in the `Gemfile` and run `bundle install` if needed.

## Debugging and Testing Guide

### 1. Write Tests First

Use RSpec to write tests for each model and controller. Here’s where to start:

- **Model Tests** (`spec/models`): Test validations and associations for `User`, `Post`, and `Comment`.
  - Use `shoulda-matchers` to test associations and validations.
- **Request Tests** (`spec/requests`): Write tests for each API endpoint in `UsersController`, `PostsController`, and `CommentsController`.
  - Test both successful and unsuccessful scenarios.
  - Test JSON responses and ensure they contain the expected structure and data.

### 2. Use Pry for Debugging

Use `binding.pry` to inspect data, troubleshoot errors, and understand application flow. Here are some places to add `binding.pry`:

- **Controllers**: Inside each action to check parameters, instance variables, and serialized data.
- **Models**: Inside associations or custom methods to troubleshoot relationships.
- **Serializers**: Inside the serializer code to inspect data being serialized.

### Testing and Debugging Tips

- **Run Tests**: Use `rspec` to run all tests and identify failures. Tests will help you spot where functionality isn’t working as expected.
- **Use Pry**: Insert `binding.pry` to pause code execution and examine variables and instance data step-by-step.
- **Check Console Logs**: Rails logs provide detailed error messages and line numbers, helping to locate issues quickly.

### Sample Tests

1. **Model Tests**

   Example: Test `User` model validations and associations.

   ```ruby
   # spec/models/user_spec.rb
   require 'rails_helper'

   RSpec.describe User, type: :model do
     it { should validate_presence_of(:name) }
     it { should validate_presence_of(:email) }
     it { should have_many(:posts) }
     it { should have_many(:comments).through(:posts) }
   end
   ```

2. **Request Tests**

  Example: Test `GET /users` in UsersController.
  ```ruby 
  # spec/requests/users_spec.rb
  require 'rails_helper'

  RSpec.describe 'Users API', type: :request do
    describe 'GET /users' do
      it 'returns a list of users' do
        create_list(:user, 3)
        get '/users'
        
        expect(response).to have_http_status(:ok)
        users = JSON.parse(response.body)
        expect(users['data'].size).to eq(3)
      end
    end
  end
  ```