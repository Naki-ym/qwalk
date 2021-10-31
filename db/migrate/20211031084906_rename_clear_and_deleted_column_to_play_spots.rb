class RenameClearAndDeletedColumnToPlaySpots < ActiveRecord::Migration[6.1]
  def change
    rename_column :play_spots, :clear, :clear_flg
    rename_column :play_spots, :deleted, :delete_flg
  end
end
