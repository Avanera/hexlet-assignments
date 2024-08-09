# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'post has one creator from users table' do
    assert_equal posts(:one).creator, users(:one)
    assert_equal users(:one).posts, [posts(:one)]
  end
end
