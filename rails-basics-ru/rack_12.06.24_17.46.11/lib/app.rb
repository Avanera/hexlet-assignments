# frozen_string_literal: true

require 'rack'
require_relative 'app/admin_policy'
require_relative 'app/execution_timer'
require_relative 'app/signature'
require_relative 'app/router'

module App
  def self.init
    Rack::Builder.new do |builder|
      # builder.use AdminPolicy
      # builder.use Signature
      # внутри блока Rack::Builder.new контекст (self) уже является объектом Rack::Builder.
      # => методы use и run могут быть вызваны непосредственно без явного указания builder
      use Rack::Reloader
      builder.run Router.new
    end
  end

  # def call(env)
  #   [status, headers, body]
  # end

  # private

  # def status
  #   200
  # end

  # def headers
  #   {}
  # end

  # def body
  #   []
  # end
end
