class CreatePlaySpots < ActiveRecord::Migration[6.1]
  def change
    create_table :play_spots do |t|
      t.integer :user_id, null: false
      t.integer :spot_id, null: false
      t.integer :play_cuest_id, null: false
      t.boolean :clear, null: false, default: false

      t.timestamps
    end
  end
end
