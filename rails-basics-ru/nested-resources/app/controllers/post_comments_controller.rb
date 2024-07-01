# frozen_string_literal: true

class PostCommentsController < ApplicationController
  before_action :set_post_comment, only: %i[edit update destroy]

  def edit; end

  def create
    @post_comment = PostComment.new(post_comment_params.merge(post_id: params[:post_id]))

    if @post_comment.save
      redirect_to post_url(@post_comment.post), notice: 'Comment was successfully created.'
    else
      redirect_to post_url(@post_comment.post), error: 'Could not create a comment'
    end
  end

  def update
    if @post_comment.update(post_comment_params)
      redirect_to post_url(@post_comment.post), notice: 'Comment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = @post_comment.post
    @post_comment.destroy!

    redirect_to post_url(post), notice: 'Comment was successfully deleted.'
  end

  private

  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
end
