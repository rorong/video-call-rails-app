class BlogsController < ApplicationController
  def index
    @posts = blog_service.posts
  end

  def show
    @post = blog_service.post(params[:id])
  end
  
  private
    def blog_service
      @blog_service ||= BlogService.new
    end
end
