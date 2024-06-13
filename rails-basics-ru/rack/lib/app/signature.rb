# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, prev_body = @app.call(env)

    hash = Digest::SHA256.hexdigest(prev_body.join)
    next_body = prev_body.push('<br>', hash)

    [status, headers, next_body]
  end
end
