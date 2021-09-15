class AddPublishToQuests < ActiveRecord::Migration[6.1]
  def change
    add_column :quests, :publish, :boolean, default: false, null: false
  end
end
