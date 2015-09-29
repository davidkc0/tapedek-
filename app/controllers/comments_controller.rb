class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @comments = @post.root_comments
  end

  def create
    post = Post.find(comment_params[:commentable_id])
    parent_post = Comment.find(comment_params[:parent_id]) if comment_params[:parent_id].present?
    user_id = current_user.id
    comment = Comment.build_from(post,user_id,comment_params[:body])
    if comment.save
      comment.move_to_child_of(parent_post) if parent_post
      flash[:success] = "comment created."
      redirect_to comments_post_path(post) and return
    else
      flash[:error] = "#{comment.errors.full_messages}"
      redirect_to :back and return
    end
  end

  def update
    @comment = Comment.find(params[:id])
    redirect_to :back if @comment.user != current_user

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to(@comment, :notice => 'comment was successfully updated.') }
        # Handles BIP attributes (everything but attachment)
        format.json { respond_with_bip(@comment) }
        # Handles attachment
        format.js
      else
        format.html { render :action => "edit" }
        # Handles BIP attributes (everything but attachment)
        format.json { respond_with_bip(@comment) }
        # Handles attachment
        format.js
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if comment.user = current_user
    flash[:succes] = "comment deleted."
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type,
                                      :parent_id)
    end
end
