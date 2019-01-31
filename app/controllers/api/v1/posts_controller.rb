module Api::V1

  class PostsController < BaseController

    def index
      total_posts = Post.order(published_at: :desc)
      posts = total_posts.page(params[:page]).per(params[:per_page])

      response.headers['posts_count'] = total_posts.count
      response.headers['total_pages'] = posts.total_pages
      render json: posts
    end

    def show
      post = Post.find(params[:id])
      render json: post
    end

    def create
      if current_user
        post = Post.new(post_params)
        post.user = current_user
        if post.save
          render json: post
        else
          render json: { errors: post.errors.messages }
        end
      else
        render json: {}, status: 401
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :published_at)
    end

  end

end