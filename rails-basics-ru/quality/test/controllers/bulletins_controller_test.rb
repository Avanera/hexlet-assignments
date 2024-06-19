# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'opens all bulletins page' do
    get bulletins_url

    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select "a[href='/bulletins/1']", 'Title one'
    assert_select 'p', 'This bulletin is about Title one'
    assert_select "a[href='/bulletins/2']", 'Title two'
    assert_select 'p', 'This bulletin is about Title two'
  end

  test 'opens one bulletin page' do
    get bulletin_url(bulletins(:one))

    assert_response :success
    assert_select 'h1', 'Title one'
    assert_select 'p', 'This bulletin is about Title one'

    assert_select "a[href='/bulletins']", 'Bulletins list'
  end
end
