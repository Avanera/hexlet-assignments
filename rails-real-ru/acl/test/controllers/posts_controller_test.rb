# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users :one
    @attrs = {
      title: Faker::Book.title,
      body: Faker::Books::Dune.quote
    }
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'guest should raise error from new' do
    get new_post_url
    assert_redirected_to root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]
  end

  test 'signed user should get new' do
    sign_in_as :one

    get new_post_url
    assert_response :success
  end

  test 'guest cant create post' do
    post posts_url, params: { post: @attrs }

    blog_post = Post.find_by(@attrs)
    assert_not blog_post
  end

  test 'signed user can create post' do
    sign_in_as :one

    post posts_url, params: { post: @attrs }

    blog_post = Post.find_by(@attrs)
    assert { blog_post }
    assert { blog_post.author == @user }

    assert_redirected_to post_url(blog_post)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'author can edit' do
    sign_in_as :one

    get edit_post_url(@post)
    assert_response :success
  end

  test 'admin can edit' do
    sign_in_as :admin

    get edit_post_url(@post)
    assert_response :success
  end

  test 'non author cant get edit' do
    sign_in_as :two

    get edit_post_url(@post)
    assert_redirected_to root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]
  end

  test 'author can update post' do
    sign_in_as :one

    patch post_url(@post), params: { post: @attrs }
    @post.reload

    assert { @post.title == @attrs[:title] }
    assert_redirected_to post_url(@post)
  end

  test 'admin can update post' do
    sign_in_as :admin

    patch post_url(@post), params: { post: @attrs }
    @post.reload

    assert { @post.title == @attrs[:title] }
    assert_redirected_to post_url(@post)
  end

  test 'not author cant update post' do
    patch post_url(@post), params: { post: @attrs }
    assert_redirected_to root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]

    @post.reload

    assert { @post.title != @attrs[:title] }
  end

  test 'only admin can destroy post' do
    sign_in_as :admin

    delete post_url(@post)

    assert { !Post.exists?(@post.id) }
    assert_redirected_to posts_url
  end

  test 'non admin cant destroy post' do
    sign_in_as :one

    delete post_url(@post)
    assert_redirected_to root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]

    assert { Post.exists?(@post.id) }
  end
end
