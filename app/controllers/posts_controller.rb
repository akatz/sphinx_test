class PostsController < ApplicationController
  def index
    if params[:keyword]
      @posts = Posts.search(params[:keyword])
    else
      @posts = Posts.all
    end
  end
  
  def show
    @posts = Posts.find(params[:id])
  end
  
  def new
    @posts = Posts.new
  end
  
  def create
    @posts = Posts.new(params[:posts])
    if @posts.save
      flash[:notice] = "Successfully created posts."
      redirect_to @posts
    else
      render :action => 'new'
    end
  end
  
  def edit
    @posts = Posts.find(params[:id])
  end
  
  def update
    @posts = Posts.find(params[:id])
    if @posts.update_attributes(params[:posts])
      flash[:notice] = "Successfully updated posts."
      redirect_to @posts
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @posts = Posts.find(params[:id])
    @posts.destroy
    flash[:notice] = "Successfully destroyed posts."
    redirect_to posts_url
  end
  def search
    @posts = Post.search(params[:keyword])
  end
end
