class AddUserIdToQuests < ActiveRecord::Migration[6.1]
  def change
    add_column :quests, :user_id, :integer
  end
end
