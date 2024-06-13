# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    request = Rack::Request.new(env)

    case request.path
    when '/'
      status = 200
      body = ['Hello, World!']
    when '/about'
      status = 200
      body = ['About page']
    else
      status = 404
      body = ['404 Not Found']
    end
    [status, { 'Content-Type' => 'text/html' }, body]
  end
end
