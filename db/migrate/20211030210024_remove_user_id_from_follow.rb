class RemoveUserIdFromFollow < ActiveRecord::Migration[6.1]
  def change
    remove_reference :follows, :user, null: false, foreign_key: true
  end
end
