# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    request = Rack::Request.new(env)

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
    [status, {}, body]
  end
end
