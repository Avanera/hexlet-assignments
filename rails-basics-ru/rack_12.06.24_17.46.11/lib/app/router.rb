# frozen_string_literal: true

require 'rack'
# require 'pry'

class Router
  def initialize(app)
    @app = app
  end

  def call(env)
    p ' ==========='
    request = Rack::Request.new(env)
    status, headers, body = @app.call(env)
    if request.path == '/'
      status = 200
      body = ['Hello, World!']
    elsif request.path == '/about'
      status = 200
      body = ['About page']
    else
      status = 404
      body = ['404 Not Found']
    end
    [status, headers, body]
  end
end
