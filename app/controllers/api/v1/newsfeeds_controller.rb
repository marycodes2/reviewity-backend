module Api::V1
  class NewsfeedsController < ApplicationController
    def index
      render json: posts_with_comments
    end

    private

    def posts_with_comments
      Post.all.map do |post|
        {
          id: post.id,
          content: post.content,
          subject: post.subject,
          author: post.user.first_name,
          comments: comments_for_post(post)
        }
      end
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
  end
end
