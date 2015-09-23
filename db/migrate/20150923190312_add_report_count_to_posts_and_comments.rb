class AddReportCountToPostsAndComments < ActiveRecord::Migration
  def change
    add_column :posts, :report_count, :integer, default: 0
    add_column :comments, :report_count, :integer, default: 0
  end
end
