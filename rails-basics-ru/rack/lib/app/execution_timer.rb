# frozen_string_literal: true

require 'digest'

# Adds a log message to the body without changing the cryptographic hash of the response body,
# because Signature middleware adds a hash before ExecutionTimer middleware adds a log message
class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, prev_body = @app.call(env)
    time_spent = (Time.now - start_time) * 1_000_000
    log_message = "App took #{time_spent.to_i} microseconds."
    next_body = prev_body.push('</br>', log_message)

    [status, headers, next_body]
  end
end
