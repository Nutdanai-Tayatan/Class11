class RemoveFollowingIdFromFollow < ActiveRecord::Migration[6.1]
  def change
    remove_column :follows, :following_id, :integer
  end
end
