class AddProviderToPost < ActiveRecord::Migration
  def change
    add_column :posts, :provider, :string
  end
end
