class ChangeClearInPlayQuest < ActiveRecord::Migration[6.1]
  def change
    change_column :play_quests, :clear, :boolean, default: false, null: false
  end
end
