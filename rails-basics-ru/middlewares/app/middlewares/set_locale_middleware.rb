# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    locale = req.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    I18n.locale = locale || I18n.default_locale

    @status, @headers, @response = @app.call(env)

    [@status, @headers, @response]
  end
end
