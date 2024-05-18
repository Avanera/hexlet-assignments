# frozen_string_literal: true

require 'forwardable'
require 'uri'

#
# Represents a URL object for manipulation and comparison.
#
# Example:
#   url = Url.new('https://example.com/path?param1=value1&param2=value2')
#   url.query_params
#   # => { param1: 'value1', param2: 'value2' }
#   url.scheme
#   # => 'https'
#   url.host
#   # => 'example.com'
#
#   url.query_param(:param1)
#   # => 'value1'
#
#   url.query_param(:new_param, 'ehu')
#   # => 'ehu'
#
#   url2 = Url.new('https://example.com/path?param2=value2&param1=value1')
#   url == url2
#   # => true
#
class Url
  extend Forwardable
  include Comparable

  attr_reader :url

  def_delegators :url, :scheme, :host, :port

  def initialize(url)
    @url = URI(url)
  end

  def query_params
    params_hash(url)
  end

  def query_param(key, value = nil)
    params_hash(url)[key] || value
  end

  def <=>(other)
    make_hash(url) <=> make_hash(other.url)
  end

  private

  # Creates a hash for URL comparison to ignore parameter order.
  def make_hash(the_url)
    url_without_params = the_url.to_s.split('?').first
    { url_without_params: url_without_params }.merge(params_hash(the_url))
  end

  def params_hash(the_url)
    query = the_url.query
    return {} if query.nil?

    Hash[URI.decode_www_form(query)].transform_keys(&:to_sym)
  end
end
