class AddFollowingIdToFollow < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :following_id, :integer
  end
end
