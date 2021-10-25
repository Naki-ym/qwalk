class AddDeleteToPlayQuests < ActiveRecord::Migration[6.1]
  def change
    add_column :play_quests, :deleted, :boolean, default: false, null: false
  end
end
