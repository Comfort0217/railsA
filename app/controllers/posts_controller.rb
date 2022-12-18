class PostsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @q = Post.ransack(params[:q])
    @tag_list = Tag.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(',')  
    if @post.save
       @post.save_tag(tag_list)
      redirect_to post_path(@post), success: 'ポストを作成しました'
    else
      flash.now[:danger] = 'ポストを作成できませんでした'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @post = current_user.posts.find(params[:id])
    # pluckはmapと同じ意味です！！
    @tag_list=@post.tags.pluck(:tag_name).join(',')
  end

  def update
    @post = current_user.posts.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
       redirect_to post_path(@post.id),notice:'投稿完了しました:)'
    else
      render:edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: 'ポストを削除しました'
  end

  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def post_params
    params.require(:post).permit(:title, :body,)
  end
end