class RemoveFolloweeIdFromFollow < ActiveRecord::Migration[6.1]
  def change
    remove_column :follows, :followee_id, :integer
  end
end
