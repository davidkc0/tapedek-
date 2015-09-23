class AddReportCountToPostsAndComments < ActiveRecord::Migration
  def change
    add_column :posts, :reports_count, :integer, default: 0
    add_column :comments, :reports_count, :integer, default: 0
  end
end
