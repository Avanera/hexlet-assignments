# frozen_string_literal: true

require 'digest'

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, body = @app.call(env)
    display_time_spent(start_time)

    [status, headers, body]
  end

  private

  def display_time_spent(start_time)
    time_spent = (Time.now - start_time) * 1e+6
    $stdout.write("The time taken to execute the site in microseconds: #{time_spent.to_i}")
  end
end
