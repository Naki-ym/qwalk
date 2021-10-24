class RenamePlayCuestIdColumnToPlaySpots < ActiveRecord::Migration[6.1]
  def change
    rename_column :play_spots, :play_cuest_id, :play_quest_id
  end
end
