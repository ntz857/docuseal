# config/initializers/cors.rb
require 'rack/cors'
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
    #   'localhost', '127.0.0.1', '*.twebeads.com', 'twebeads.com', '*.apinibee.com' , 'apinibee.com'
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end