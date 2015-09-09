class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy ]
  before_filter :authenticate_user!, only: [:create, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = grab_correct_post
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.create(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path(sort_by: "added_on"), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

 def upvote
    @post = Post.find (params[:id])
    session[:voting_id] = request.remote_ip
    voter = VotingSession.find_or_create_by(ip: session[:voting_id])
    voter.likes @post
    respond_to do |format|
      format.js
    end
end

def downvote
  @post = Post.find (params[:id])
  session[:voting_id] = request.remote_ip
  voter = VotingSession.find_or_create_by(ip: session[:voting_id])
  voter.dislikes @post
  respond_to do |format|
      format.js
  end
end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :video_url)
    end

    def grab_correct_post
    if params[:sort_by] == "added_on"
      @added_on = "sort-active"
      Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 8)
    else
      @most_popular = "sort-active"
      Post.all.order(:cached_votes_score =>:desc).paginate(page: params[:page], per_page: 8)
    end
    end
end
