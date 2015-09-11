class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id, null: false
      t.string :provider
      t.string :uid
      t.string :token

      t.timestamps null: false
    end
  end
end
