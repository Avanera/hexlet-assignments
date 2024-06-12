# frozen_string_literal: true
require 'rack'

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    [403, {}, []] if request.path == '/admin'
  end
end
