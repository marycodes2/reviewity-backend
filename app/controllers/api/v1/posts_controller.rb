module Api::V1
  class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render json: posts_with_comments
    end

    def create
      @post = Post.create(
        subject: params[:subject],
        content: params[:post_content],
        user: User.find_by(id: params[:user_id]),
      )

      if @post.valid?
        render json: post_with_comments(post)
      else
        status :unauthorized
      end
    end

    def destroy
      post = Post.find(params[:id])

      if current_user.owns_post?(post)
        deleted_post = post.destroy

        render json: deleted_post
      else
        status :unauthorized
      end
    end

    private

    attr_reader :post

    def posts_with_comments
      Post.all.reverse.map do |post|
        post_with_comments(post)
      end
    end

    def post_with_comments(post)
      {
        author: post.user.first_name,
        author_id: post.user.id,
        comments: comments_for_post(post),
        content: post.content,
        id: post.id,
        subject: post.subject,
      }
    end

    def comments_for_post(post)
      post.comments.map do |comment|
        {
          id: comment.id,
          content: comment.content,
          author: comment.user.first_name
        }
      end
    end

    def post_params
      params.permit(:subject, :post_content, :id, :user_id)
    end
  end
end
