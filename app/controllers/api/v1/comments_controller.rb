module Api::V1
  class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      @comment = Comment.create(
        content: params[:content],
        user: user,
        post: post,
      )

      if @comment.valid?
        render json: returned_comment
      else
        status :unauthorized
      end
    end

    def destroy
      comment = Comment.find(params[:id])

      if current_user.owns_comment?(comment)
        deleted_comment = comment.destroy

        render json: deleted_comment
      else
        status :unauthorized
      end
    end

    private

    attr_reader :comment

    def returned_comment
      {
        author: user.first_name,
        author_id: user.id,
        content: comment.content,
        id: comment.id,
        post_id: post.id,
      }
    end

    def user
      User.find(params[:user_id])
    end

    def post
      Post.find(params[:post_id])
    end

    def comment_params
      params.permit(:content, :post_id, :user_id)
    end
  end
end
