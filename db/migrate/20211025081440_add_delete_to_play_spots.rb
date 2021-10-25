class AddDeleteToPlaySpots < ActiveRecord::Migration[6.1]
  def change
    add_column :play_spots, :deleted, :boolean, default: false, null: false
  end
end
