class StaticPagesController < ApplicationController
  before_filter :validate_admin!, only: [:admin]

  def home
  end

  def about
  end

  def admin
    @reported_posts = Post.where("reports_count > 0").order(reports_count: :desc).limit(15)
    @reported_comments = Comment.where("reports_count > 0").order(reports_count: :desc).limit(15)
    @most_posts = User.joins(:posts).group('users.id').order('count(posts.id) desc').limit(10)
  end

  private

    def validate_admin!
      unless current_user and current_user.admin?
        flash[:danger] = "You are not admin!"
        redirect_to root_path and return
      end
      true
    end
end
