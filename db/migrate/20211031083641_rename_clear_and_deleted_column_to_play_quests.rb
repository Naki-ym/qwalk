class RenameClearAndDeletedColumnToPlayQuests < ActiveRecord::Migration[6.1]
  def change
    rename_column :play_quests, :clear, :clear_flg
    rename_column :play_quests, :deleted, :delete_flg
  end
end
